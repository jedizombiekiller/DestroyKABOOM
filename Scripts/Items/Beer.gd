extends Item

@export var six_pack : bool = false
@export var weak_heal : int = 20
@export var strong_heal : int = 40

func change_player_value(body):
	if body is Protagonist:
		if six_pack:
			body.heal(strong_heal)
		else:
			body.heal(weak_heal)
