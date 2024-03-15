extends Node

@onready var game_scene = get_parent()
var active

func talk1():
	if active:
		game_scene.talk("progress1")


func _on_game_scene_progressed(room):
	if active:
		match room:
			1:
				game_scene.talk("progress2")
			2:
				game_scene.talk("progress3")
			3:
				game_scene.talk("progress4")
	pass # Replace with function body.
