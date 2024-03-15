extends Control

var main_menu = load("res://Scenes/UI/main_menu.tscn")
var game = load("res://Scenes/MainScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuButton.hide()
	$RetryButton.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	$MenuButton.show()
	$RetryButton.show()
	pass # Replace with function body.


func _on_menu_button_button_down():
	$MenuButton.hide()
	$RetryButton.hide()
	$ScreenFade/AnimationPlayer.play("FadeOut")
	await $ScreenFade/AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(main_menu)
	pass # Replace with function body.


func _on_retry_button_button_down():
	$MenuButton.hide()
	$RetryButton.hide()
	$ScreenFade/AnimationPlayer.play("FadeOut")
	await $ScreenFade/AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(game)
	pass # Replace with function body.
