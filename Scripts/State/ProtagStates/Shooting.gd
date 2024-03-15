extends ProtagState
class_name ProtagShoot

var current_nearest_troop
@export var update_time : float
var time : float

func enter():
	super()
	current_nearest_troop = protag.nearest_troop
	time = 0.01

func process_physics(delta):
	#timer stuff
	if time <= 0:
		current_nearest_troop = protag.nearest_troop
		time = update_time
	else:
		time -= delta
	
	if is_instance_valid(current_nearest_troop):
		#looks at troop
		protag.troop_target_setup(current_nearest_troop)
		protag.change_gun(current_nearest_troop)
		protag.look_at_poi(protag.nearest_troop.global_position, delta)
		
		#protag.set_movement_target(protag.nearest_troop.global_position)
		if round(protag.global_position.distance_to(protag.nearest_troop.global_position)) == 2.5:
			protag.stand = true
			protag.run_away = false
		elif protag.global_position.distance_to(protag.nearest_troop.global_position) < 2.5:
			protag.stand = false
			protag.run_away = true
		else:
			protag.stand = false
			protag.run_away = false
		
		protag.do_movement(delta)
		
	else:
		#protag.look_at_poi(protag.point_of_interest.global_position, delta)
		transitioned.emit(self, next_state.name)

func exit():
	super()


