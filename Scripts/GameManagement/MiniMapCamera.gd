extends Camera3D

@export var main_scene : Node3D
@export var positions : Array[Vector3] = []
@export var rotations : Array[Vector3] = []

func _process(delta):
	position = positions[main_scene.progress]
	rotation_degrees = rotations[main_scene.progress]
	pass

func _input(event):
	if event.is_action_pressed("Click"):
		shoot_ray()
	pass


func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.collide_with_bodies = false
	ray_query.collide_with_areas = true
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	#if raycast_result["collider"].room
	#print(raycast_result)
	#if collided.get_parent().get_parent().room
	return raycast_result
