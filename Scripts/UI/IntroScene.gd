extends Control

var main_menu = load("res://Scenes/UI/main_menu.tscn")
const BALLOON = preload("res://Dialogue/Intro/balloon.tscn")
@export var dialogue_resource : DialogueResource
@export var dialogue_start : String
@export var scene_time : float
var time : float

func _ready():
	time = scene_time
	var balloon = BALLOON.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	pass # Replace with function body.


func _process(delta):
	if time <= 0:
		#var anim = $CanvasLayer/ScreenFade/AnimationPlayer
		#anim.play("FadeOut")
		#await  anim.animation_finished
		#get_tree().change_scene_to_packed(main_menu)
		#get_tree().change_scene_to_file.bind("res://Scenes/UI/main_menu.tscn").call_deferred()
		to_menu()
	else:
		time -= delta

func to_menu():
	var anim = $CanvasLayer/ScreenFade/AnimationPlayer
	anim.play("FadeOut")
	await  anim.animation_finished
	get_tree().change_scene_to_file.bind("res://Scenes/UI/main_menu.tscn").call_deferred()
	#get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_button_button_down():
	$Button.disabled = true
	to_menu()
	pass # Replace with function body.
