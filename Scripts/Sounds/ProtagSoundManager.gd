extends Node3D
class_name ProtagSoundManager

@export var protag : Protagonist
@export var hurt_sounds : Array[AudioStreamPlayer3D]
@export var death_sounds : Array[AudioStreamPlayer3D]
@export var bravery_sounds : Array[AudioStreamPlayer3D]
@export var fear_sounds : Array[AudioStreamPlayer3D]
@export var computer_sounds : Array[AudioStreamPlayer3D]
@export var win_sounds : Array[AudioStreamPlayer3D]
@export var domination_sounds : Array[AudioStreamPlayer3D]

@export var wilhelm : AudioStreamPlayer3D
var current_voice : AudioStreamPlayer3D = null
'''
Have a main variable called "current_voice"
start of as null and have code that does nothing when it's null
when playing a sound, set current_voice to that sound
code will detect that it isn't null and play it
once finished, it will go back to null

if another sound is played while there's one playing,
stop current sound and play new sound
ONLY IF interrupted sound isn't a sentence
OR IF interrupet sound isn't a death sound
if a sentence plays but a death sound is requested
play the death sound
'''
func _process(delta):
	if current_voice != null:
		if !current_voice.playing:
			current_voice.play()
		if current_voice.finished:
			current_voice = null
	pass

func request_sound(sound):
	if protag.health <= 0:
		if sound.is_in_group("Death"):
			current_voice = sound
		else:
			return
	if current_voice == null:
		current_voice = sound
	else:
		if !current_voice.is_in_group("Sentence"):
			current_voice.stop()
			current_voice = sound
		else:
			if sound.is_in_group("Death"):
				current_voice.stop()
				current_voice = sound
		if !current_voice.is_in_group("Death"):
			current_voice = sound

func play_hurt():
	if !hurt_sounds.is_empty():
		var sound = hurt_sounds.pick_random()
		request_sound(sound)

func play_death():
	if !death_sounds.is_empty():
		var sound = death_sounds.pick_random()
		request_sound(sound)

func play_wilhelm():
	request_sound(wilhelm)

func play_bravery():
	if !bravery_sounds.is_empty():
		var sound = bravery_sounds.pick_random()
		request_sound(sound)

func play_fear():
	if !fear_sounds.is_empty():
		var sound = fear_sounds.pick_random()
		request_sound(sound)

func play_computer():
	if !computer_sounds.is_empty():
		var sound = computer_sounds.pick_random()
		request_sound(sound)

func play_win():
	if current_voice != null:
		return
	
	if !win_sounds.is_empty():
		var sound = win_sounds.pick_random()
		request_sound(sound)

func play_domination():
	if !domination_sounds.is_empty():
		var sound = domination_sounds.pick_random()
		request_sound(sound)
