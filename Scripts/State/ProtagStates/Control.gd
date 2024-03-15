extends ProtagState
class_name ProtagControl

func enter():
	super()
	pass

func process_physics(delta):
	var input_dir = Input.get_axis("ui_up", "ui_down")
	var rotation_direction = Input.get_axis("ui_right", "ui_left")
	var direction = (protag.transform.basis * Vector3(0, 0, input_dir)).normalized()
	if direction:
		protag.velocity.x = direction.x * protag.speed
		protag.velocity.z = direction.z * protag.speed
	else:
		protag.velocity.x = move_toward(protag.velocity.x, 0, protag.speed)
		protag.velocity.z = move_toward(protag.velocity.z, 0, protag.speed)
	protag.rotation.y += rotation_direction * protag.rotation_speed * delta
