extends Node3D

func _process(delta):
	get_parent().spawn_pos = global_position
	pass
