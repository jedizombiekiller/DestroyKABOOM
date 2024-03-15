extends ProtagState
class_name ProtagFear

@export_range (0,100) var bravery_chance : int 
var wander_time : float
var computer 
@onready var timer = $Timer

var current_nearest_troop
@export var update_time : float
var time : float

func enter():
	var rand = randi_range(0, 100)
	if rand <= 50:
		protag.sound_manager.play_fear()
	timer.start()
	#print("AGHHHHH!!!!!!!!!!!!!")
	super()
	#if is_instance_valid(protag.nearest_troop):
	#	target = protag.nearest_troop.global_position
	
	current_nearest_troop = protag.nearest_troop
	time = 0.01
	
	#protag.set_movement_target(target)
	protag.stand = false
	protag.run_away = true

func process_physics(delta):
	if time <= 0:
		current_nearest_troop = protag.nearest_troop
	else:
		time = update_time
		time -= delta
	
	if is_instance_valid(current_nearest_troop):
		#looks at troop
		protag.point_of_interest.global_position = current_nearest_troop.global_position
		
		protag.change_gun(current_nearest_troop)
		  
		#protag.set_movement_target(protag.global_position - protag.nearest_troop.global_position)
		#protag.get_nearest_troop()
		protag.look_at_poi(current_nearest_troop.global_position, delta)
		protag.do_movement(delta)
	else:
		transitioned.emit(self, next_state.name)


func exit():
	#print("I fear no longer")
	protag.run_away = false
	var rand = randi_range(0,100)
	if rand <= 50:
		protag.sound_manager.play_bravery()
	timer.stop()


func _on_timer_timeout():
	var rand = randi_range(0,100)
	if rand <= bravery_chance:
		print("I fear no longer")
		transitioned.emit(self, next_action_state.name)
	else:
		protag.get_nearest_troop()
		if !protag.nearest_troop:
			return
	pass # Replace with function body.
