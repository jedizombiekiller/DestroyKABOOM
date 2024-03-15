extends ProtagState
class_name ProtagDie

func enter():
	print("I AM DEAD")
	protag.deactivate_gun()
	protag.get_node("ChaingunArea").enabled = false
	protag.get_node("PistolArea").enabled = false
	protag.get_node("ShotgunArea").monitoring = false
	var rand = randi_range(0, 100)
	if rand <= 20:
		protag.sound_manager.play_wilhelm()
	else:
		protag.sound_manager.play_death()
	#protag.ammo_mag = 0
	super()

