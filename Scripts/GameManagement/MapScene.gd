extends Node3D

@export var doors : Array[MeshInstance3D]
@export var door_speed : float = 0.01
var height = 4

func open_door(num):
	while doors[num].position.y < height:
		doors[num].position.y += door_speed
		pass
	pass


func _on_computer_1_computer_action():
	$AudioStreamPlayer.play()
	open_door(0)
	pass # Replace with function body.


func _on_computer_2_computer_action():
	$AudioStreamPlayer.play()
	open_door(1)
	pass # Replace with function body.


func _on_computer_3_computer_action():
	$AudioStreamPlayer.play()
	open_door(2)
	pass # Replace with function body.
