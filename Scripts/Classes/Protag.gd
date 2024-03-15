extends CharacterBody3D
class_name Protagonist

signal protag_death
signal boss_defeat
signal bullet_shot

var boss_defeated = false

@onready var sound_manager = $ProtagSoundManager

const JUMP_VELOCITY = 4.5
@export var health : int = 400
@export var speed = 15.0
@export_range (0,100) var fear_chance : int  = 50
var rotation_speed : float = 1.5
var turn_vel : float = 0
var turn_accl : float = 10
@export var max_turn_accl : float = 1.5
@export var max_turn_vel : float = 1000

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var player_controlled = false
var run_away = false
var stand = false
var do_code = false
@onready var point_of_interest = $PointOfInterest
@onready var state_machine = $StateMachine
@onready var look_target = $LookTarget
@onready var pistol_area = $PistolArea

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
var movement_target_position: Vector3
var nearest_troop : TrooperClass


var kill_count : int = 0
var update_count : int = 0

var current_gun : int = 1 #0 - pistol, 1 - shotgun
@export var guns : Array[Node3D]
var ammo_shell : int = 10
var ammo_mag : int = 50

'''
Protag Notes:
	4 Weapon types - Pistol, Shotgun, Missile Launcher, and ???
	
	Pistol is long ranged and fires in a straight line.
	Deals 10 damage and has a 30% chance of missing
	
	Shotgun is short ranged and fires in a cone
	Deals 70 up close and 10 far

Movement Notes:
	Strafing should be possible. Have movement be unique to rotation.
	Use actual pathfinding for player as we want it to be smart.
	Look should not be instant and instead be gradual.
	What this means is that it should take time to face it's target.
	I'm Thinking of having it work like this:
		Lets start looking forward. ASsume the target is on your right
		turn velocity should start at 0. 
		if target is to your right:
			Add turn_accl to turn_vel
		if target is to your left:
			Subtract turn_accl to turn_vel
		Have a max turn speed as well. It should overshoot as well.
		Have this also linked to the guns
'''

func _ready():
	switch_gun(1)
	get_nearest_troop()
	rotation = Vector3(0, 0, 0)
	
	call_deferred("actor_setup")

func _process(delta):
	if do_code:
		if !$Typing.playing:
			$Typing.play()
	else:
		$Typing.stop()

func _physics_process(delta):
	if health <= 0 and !state_machine.current_state.name == "Die":
		health = 0
		die()
	if health > 400:
		health = 400
	get_nearest_troop()
	if player_controlled:
		state_machine.on_child_transition(state_machine.current_state, "Control")
	else:
		pass
	if !boss_defeated:
		if kill_count % 3 == 0 and update_count != kill_count:
			heal(20)
			update_count = kill_count
			var rand = randi_range(0, 100)
			if rand <= 50:
				sound_manager.play_domination()
	
	do_movement(delta)

func heal(damage):
	health += damage

func hurt(damage):
	health -= damage
	var rand = randi_range(0,100)
	if rand <= fear_chance and state_machine.current_state.name != "Fear":
		state_machine.on_child_transition(state_machine.current_state, "Fear")
	else:
		sound_manager.play_hurt()

func die():
	$MiniMapHead.queue_free()
	emit_signal("protag_death")
	state_machine.on_child_transition(state_machine.current_state, "Die")
	#queue_free()

func finish_game():
	emit_signal("boss_defeat")
	pass

func do_movement(delta):
	if not is_on_floor():
		velocity.y -= gravity
	#if nav_agent.is_navigation_finished():
		#return
	var current_agent_pos : Vector3 = global_position
	var next_path_pos : Vector3 = nav_agent.get_next_path_position()
	
	velocity = current_agent_pos.direction_to(next_path_pos) * speed/2 
	if run_away:
		velocity.x *= -1
		velocity.z *= -1
	elif stand:
		velocity.x *= 0
	move_and_slide()

func look_at_poi(pos : Vector3, delta):
	var vel = pos - global_position
	var target_angle = atan2(-vel.x, -vel.z)
	
	rotation.y = lerp_angle(rotation.y, target_angle, delta*turn_accl)
	#idk how this works but thanks to this video for it
	#https://youtu.be/PQNZvQFJbQ4?si=C4WTA_fd_1PwnjrP


func get_nearest_troop():
	# get all troops. consider changing to in view?
	var troops : Array = get_tree().get_nodes_in_group("Trooper")
	if troops.is_empty():
		nearest_troop = null
		return
	#assume the first is closer
	nearest_troop = troops[0]
	for troop in troops:
		if troop:
			if troop.global_position.distance_to(global_position) < nearest_troop.global_position.distance_to(global_position):
				nearest_troop = troop

func troop_target_setup(current_nearest_troop):
	point_of_interest.global_position = current_nearest_troop.global_position
	#look_at_poi(current_nearest_troop.global_position, 0)
	set_movement_target(current_nearest_troop.global_position)

func change_gun(current_nearest_troop):
	#get_nearest_troop()
	if is_instance_valid(current_nearest_troop):
		var distance_to_troop = global_position.distance_to(current_nearest_troop.global_position)
		distance_to_troop = global_position.distance_to(nearest_troop.global_position)
		#if current_gun != 2:
			#switch_gun(2)
		
		'''
		if you have chaingun ammo, use it
		else, if you're close, use shot gun
		else you use pistol
		'''
		
		#distance_to_troop <= 5 and 
		if ammo_mag > 0: #if you have ammo for chaingun
			switch_gun(2) # switch to chaingun
		else:
			if ammo_shell > 0 and !state_machine.current_state.name == "Fear": #if you have ammo for shotgun and you're not running away
				switch_gun(1) # switch to shotgun
			else:
				switch_gun(0) # switch to pistol

'''Navigation Stuff'''

func actor_setup():
	await get_tree().physics_frame #waits for navigation server to be set up
	
	if movement_target_position:
		set_movement_target(movement_target_position)

func set_movement_target(movement_target : Vector3):
	nav_agent.set_target_position(movement_target)

func switch_gun(gun : int): #0 is pistol, 1 is shotgun
	if current_gun == gun:
		return
	if current_gun < 0: #cannot change to a nonexistant gun
		return
	guns[current_gun].deactivate()
	guns[gun].activate()
	current_gun = gun
	pass

func deactivate_gun(): #pretty much only for death
	guns[current_gun].deactivate()
	current_gun = -1


func _on_boss_defeat():
	if !boss_defeated:
		boss_defeated = true
		sound_manager.play_win()
	pass # Replace with function body.
