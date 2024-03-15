extends Node3D
class_name Computer

@export var active : bool = false
@export var max_loading : int = 100
@export var next_computer : Computer
signal computer_action
var loading = 0


func _ready():
	pass


func _process(delta):
	if active:
		get_node("Area3D").monitoring = true
	else:
		get_node("Area3D").monitoring = false
	if loading >= max_loading:
		loading = 0
		get_parent().change_progress(1)
		computer_action.emit()
		if next_computer:
			activate_next()
		else:
			active = false
			get_parent().current_computer = null
	pass

func on_finish():
	activate_next()

func activate_next():
	active = false
	get_parent().current_computer = next_computer
	next_computer.activate()

func activate():
	active = true

func _on_area_3d_body_entered(body):
	if body is Protagonist:
		body.do_code = true
	print("coding")
	pass # Replace with function body.

func _on_area_3d_body_exited(body):
	if body is Protagonist:
		body.do_code = false
	print("not coding")
	pass # Replace with function body.
