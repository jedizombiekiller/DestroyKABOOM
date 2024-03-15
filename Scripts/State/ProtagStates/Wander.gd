extends ProtagState
class_name ProtagWander

@export var wander_time_range : Vector2 = Vector2(1,3)
var wander_time : float
var computer
#var poi = protag.point_of_interest
func enter():
	super()
	computer = get_tree().get_first_node_in_group("Computer")
	randomize_velocity()

func process_physics(delta):
	protag.do_movement(delta)
	if protag.nearest_troop:
		#protag.look_at_poi(protag.nearest_troop.global_position, delta)
		transitioned.emit(self, next_state.name)
	else:
		protag.look_at_poi(protag.point_of_interest.global_position, delta)
	pass

func process_frame(delta):
	protag.point_of_interest.global_position = computer.global_position
	#print(protag.point_of_interest)
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_velocity()
	
	#for shooting pistol
	#if protag.pistol_area.is_colliding:
		#if protag.pistol_area.get_collider().is_in_group("Trooper"):
			#var rand = randi_range(0, 100)*delta
			#if rand < 1*delta:
				#protag.pistol_area.get_collider().queue_free()
			#print("pew")

func randomize_velocity():
	protag.velocity.x = randf_range(-protag.speed, protag.speed)
	protag.velocity.z = randf_range(-protag.speed, protag.speed)
	wander_time = randf_range(wander_time_range.x,wander_time_range.y)
