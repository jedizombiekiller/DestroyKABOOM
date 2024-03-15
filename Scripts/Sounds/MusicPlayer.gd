extends Node

@export var starting_music : AudioStreamPlayer
var current_music : String
@export var fade_speed : float = 1.0

func _ready():
	if starting_music:
		current_music = starting_music.name
		starting_music.volume_db = -5
		starting_music.play()

func switch_music_to(new_music):
	#if get_node(current_music).volume_db <= -50:# if it's quiet
		#get_node(current_music).stop()  #stop the quiet song
		#current_music = get_node(new_music).name #new music is the current song
		#get_node(current_music).volume_db = -50 #makes it quiet
		#fade_in()
	#else:
		#get_node(current_music).volume_db -= fade_speed
	get_node(current_music).stop()
	get_node(new_music).play()
	pass

func fade_in():
	if get_node(current_music).volume_db < -5: #if it's too quiet
		get_node(current_music).volume_db += 1 #make it louder
	pass

func interrupt_music():
	pass


func _on_game_scene_final_room():
	switch_music_to("BossMusic")
	pass # Replace with function body.
