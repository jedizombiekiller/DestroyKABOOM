extends TrooperState
class_name TrooperMelee

@export var attack_time : float #how long to wait before attacking
@export var continuous : bool = true # should the troop keep attacking?
@export var start_with_attack : bool = true
var att_timer : float #timer to do the math

var direction


func enter():
	direction = troop.velocity/50
	troop.velocity = direction
	super() 
	if start_with_attack:
		att_timer = 0
	else:
		att_timer = attack_time
	pass

func process_physics(delta):
	troop.velocity = direction
	troop.do_movement(delta)

func process_frame(delta):
	var direction = protag.global_position - troop.global_position
	if att_timer > 0:
		att_timer -= delta
	else:
		if direction.length() < troop.troopResource.melee_dist:
			melee()
			if !continuous:
				transitioned.emit(self, next_state.name)
		else: 
			transitioned.emit(self, next_state.name) #go back to follow
		att_timer = attack_time

func melee():
	protag.hurt(troop.troopResource.melee_damage)
	troop.sound_manager.play_melee()
	GameManager.add_energy(4)

