extends Control

#stuff for volume
var master_bus = AudioServer.get_bus_index("Master")

var next_scene = load("res://Scenes/MainScene.tscn")
@onready var screen_trans = $ScreenFade/AnimationPlayer
@onready var button_sound = $ButtonSound
func _ready():
	$ScreenFade.show()
	screen_trans.play("FadeIn")
	$Credits.hide()
	$SettingsMenu.hide()
	
	$SettingsMenu/VBoxContainer/VolumeOption/VolumeSlider.value = AudioServer.get_bus_volume_db(master_bus)

func disable_buttons():
	$VBoxContainer/PlayButton.disabled = true
	$VBoxContainer/CreditsButton.disabled = true
	$VBoxContainer/SettingsButton.disabled = true

func _on_button_button_down():
	button_sound.play()
	disable_buttons()
	screen_trans.play("FadeOut")
	await screen_trans.animation_finished
	get_tree().change_scene_to_packed(next_scene)
	pass # Replace with function body.


func _on_x_button_down():
	button_sound.play()
	$Credits.hide()
	pass # Replace with function body.


func _on_credits_button_button_down():
	button_sound.play()
	$Credits.show()
	pass # Replace with function body.



func _on_quit_button_button_down():
	button_sound.play()
	screen_trans.play("FadeOut")
	await screen_trans.animation_finished
	get_tree().quit()
	pass # Replace with function body.


func _on_settings_button_button_down():
	button_sound.play()
	$SettingsMenu.show()
	pass # Replace with function body.


func _on_settings_x_button_down():
	button_sound.play()
	$SettingsMenu.hide()
	pass # Replace with function body.


func _on_button_toggled(toggled_on):
	if toggled_on:
		$SettingsMenu/VBoxContainer/DialogueOption/Button.text = "OFF"
		Settings.show_dialogue = false
	if !toggled_on:
		$SettingsMenu/VBoxContainer/DialogueOption/Button.text = "ON"
		Settings.show_dialogue = true
	pass # Replace with function body.


func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	pass # Replace with function body.
