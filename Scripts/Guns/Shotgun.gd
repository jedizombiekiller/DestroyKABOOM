extends Area3D

@export var damage_range : Array = [5,15]
@onready var timer = $Timer
@export var active = false
var shooting
var targetted_troop
var troops = []

func activate():
	active = true
	#print("Using shotgun")

func deactivate():
	active = false
	#print("No longer using shotgun")

func _ready():
	active = false
	shooting = false
	

func _process(delta):
	#troops = get_overlapping_bodies()
	
	#sets the nearest troop to target
	var targetted_troop = get_parent().nearest_troop
	if active:
		if troops:
			shooting = true
			#if targetted_troop.is_in_group("Trooper"):
				#shooting = true
		else:
			targetted_troop = null
			shooting = false
			
	##distance/7.5
	pass


func _on_body_entered(body):
	verify_troops()
	pass # Replace with function body.

func shoot():
	if get_parent().current_gun == 1:
		verify_troops()
		if get_parent().ammo_shell > 0:
			get_parent().emit_signal("bullet_shot")
			get_parent().ammo_shell -= 1
			$ShotSound.play()
			if troops:
				for troop in troops:
					if troop is TrooperClass:
						var rand = randi_range(damage_range[0], damage_range[1])
						var distance = get_parent().global_position.distance_to(troop.global_position)
						var multiplier = 1 - distance/4
						troop.hurt(damage_range[0] + damage_range[1] * multiplier)
						verify_troops()
		else:
			print("Need more shells")
			get_parent().change_gun(get_parent().nearest_troop)
			#get_parent().transitioned.emit(get_parent().current_state.self, get_parent().current_state.next_state.name)

func verify_troops(): #makes sure all troops in array are troops
	troops = get_overlapping_bodies()
	for troop in troops:
		if troop is TrooperClass:
			pass
		else:
			troops.erase(troop)

func _on_body_exited(body):
	verify_troops()
	pass # Replace with function body.


func _on_timer_timeout():
	if active and shooting:
		shoot()
	pass # Replace with function body.
