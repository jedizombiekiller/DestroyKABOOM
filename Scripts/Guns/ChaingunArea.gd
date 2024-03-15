extends StraightGun

func shoot():
	if get_parent().current_gun == 2:
		if get_parent().ammo_mag > 0:
			if is_instance_valid(get_collider()):
				if get_collider() is TrooperClass:
					get_parent().emit_signal("bullet_shot")
					get_collider().hurt(randi_range(damage_range[0], damage_range[1]))
					get_parent().ammo_mag -= 1
					$ShotSound.play()
					#print(get_parent().ammo_mag)
		else:
			get_parent().change_gun(get_parent().nearest_troop)
