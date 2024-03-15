extends Node2D

#@export var next_scene : PackedScene
var next_scene = load("res://Scenes/UI/main_menu.tscn")
@onready var menu_button = $CanvasLayer/MenuButton
@onready var screen_fade = $CanvasLayer/ScreenFade/AnimationPlayer

const BALLOON = preload("res://Dialogue/Player/balloon.tscn")
@export var dialogue_resource : DialogueResource
@export var dialogue_start : String

func _ready():
	screen_fade.play("FadeIn")
	menu_button.show()
	var balloon = BALLOON.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_button_down():
	screen_fade.play("FadeOut")
	await screen_fade.animation_finished
	get_tree().change_scene_to_packed(next_scene)
	pass # Replace with function body.



	


