extends Node3D
class_name SoundManager

@export var idle_sounds : Array[AudioStreamPlayer3D]
@export var hurt_sounds : Array[AudioStreamPlayer3D]
@export var death_sounds : Array[AudioStreamPlayer3D]
@export var melee_sounds : Array[AudioStreamPlayer3D]
@export var fireball_sounds : Array[AudioStreamPlayer3D]
@export var misc_sounds : Array[AudioStreamPlayer3D]

func play_idle():
	if !idle_sounds.is_empty():
		idle_sounds.pick_random().play()

func play_hurt():
	if !hurt_sounds.is_empty():
		hurt_sounds.pick_random().play()

func play_death():
	if !death_sounds.is_empty():
		death_sounds.pick_random().play()

func play_melee():
	if !melee_sounds.is_empty():
		melee_sounds.pick_random().play()

func play_fireball():
	if !fireball_sounds.is_empty():
		fireball_sounds.pick_random().play()

func play_misc():
	if !misc_sounds.is_empty():
		misc_sounds.pick_random().play()
