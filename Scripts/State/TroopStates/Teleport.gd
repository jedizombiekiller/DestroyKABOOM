extends TrooperState
class_name  TrooperTeleport

@export var teleport_time : float = 2
var tp_timer
#var pos_found : bool = false
var tp_position : Vector3
var pointer
func enter():
	super()
	troop.sound_manager.play_misc()
	print("teleporting....")
	pointer = troop.get_node("TeleportPointer")
	pointer.position = Vector3.ZERO
	tp_timer = teleport_time
	
	troop.pos_found = false
	troop.pointer_col.disabled = false

func process_physics(delta):
	if !troop.pos_found:
		var x = randf_range(-troop.teleport_range,troop.teleport_range)
		var z = randf_range(-troop.teleport_range,troop.teleport_range)
		pointer.position = Vector3(x,0,z)
	else:
		var distance = protag.global_position - pointer.global_position
		if distance.length() < troop.troopResource.follow_dist: #if distance between pointer and player is 
			troop.pos_found = false
	
	troop.velocity = Vector3.ZERO
	troop.do_movement(delta)

func process_frame(delta):
	if tp_timer > 0:
		tp_timer -= delta
	else:
		if troop.pos_found:
			teleport()

func teleport():
	troop.global_position = pointer.global_position #tp_position
	pointer.position = Vector3.ZERO
	transitioned.emit(self, next_state.name)
	pass

func exit():
	troop.pointer_col.disabled = true

