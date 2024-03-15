extends StraightGun


func shoot():
	if get_parent().current_gun == 0:
		if is_instance_valid(get_collider()):
			if get_collider() is TrooperClass:
				get_parent().emit_signal("bullet_shot")
				get_collider().hurt(randi_range(damage_range[0], damage_range[1]))
				$ShotSound.play()
		#if get_parent().ammo_shell > 0:
			#get_parent().switch_gun(1)
		get_parent().change_gun(get_parent().nearest_troop)
