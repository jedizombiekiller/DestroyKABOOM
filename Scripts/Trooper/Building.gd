extends TrooperClass

@export var spawn_pos : Vector3 = Vector3.ZERO
var spawn_rot
var spawn_scale
func _ready():
	spawn_pos = Vector3(53, 0, -79)
	spawn_rot = Vector3(0, -90, 0)
	spawn_scale = Vector3(1.5, 1.5, 1.5)
	super()
	set_global_position(spawn_pos)
	rotation_degrees = spawn_rot
	scale = spawn_scale

func death():
	protag.kill_count += 1
	protag.finish_game()
	#spawn_explosion()
	#drop_item()
	#queue_free()
