extends ProtagState
class_name ProtagPassive

@export var wander_time_range : Vector2 = Vector2(1,3)
var wander_time : float
var computer 
var nearest_heal

func enter():
	super()
	#computer = protag.get_parent().current_computer
	protag.stand = false
	protag.run_away = false

func process_physics(delta):
	computer = protag.get_parent().current_computer
	if protag.nearest_troop:
		#protag.look_at_poi(protag.nearest_troop.global_position, delta)
		transitioned.emit(self, next_state.name)
	else:
		var heals : Array = get_tree().get_nodes_in_group("Health_Item")
		if !heals.is_empty():
			nearest_heal = heals[0]
			for heal in heals:
				if heal.global_position.distance_to(protag.global_position) < nearest_heal.global_position.distance_to(protag.global_position):
					nearest_heal = heal
			protag.set_movement_target(nearest_heal.global_position)
			protag.point_of_interest.global_position = nearest_heal.global_position
		elif computer:
			protag.set_movement_target(computer.global_position)
			protag.point_of_interest.global_position = computer.get_node("Box").global_position
		else:
			protag.set_movement_target(protag.get_parent().go_here.global_position)
			protag.point_of_interest.global_position = protag.get_parent().go_here.global_position
			pass
		protag.do_movement(delta)
		protag.look_at_poi(protag.point_of_interest.global_position, delta)
	pass


