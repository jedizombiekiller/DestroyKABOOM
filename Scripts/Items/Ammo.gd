extends Item

@export var is_shell : bool = false
@export var ammo : int = 5

func change_player_value(body):
	if body is Protagonist:
		if is_shell:
			body.ammo_shell += ammo
		else:
			body.ammo_mag += ammo
