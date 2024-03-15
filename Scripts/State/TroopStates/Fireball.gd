extends TrooperState
class_name TrooperFireball

@export var fireball : PackedScene
@export var spawn : Node3D
@export var rev_time : float = 1 #how long it takes before firing
var rev_timer : float
@export var continuous : bool = true #whether fireballs keep shooting

@export_subgroup("Continuous")
@export var fire_rate : float = 0.1 
var rate_timer : float
@export var fire_time : float = 1.5 # how long to keep shooting for (only applies when continuous)
var fire_timer : float

func enter():
	super()
	troop.sound_manager.play_fireball()
	rev_timer = rev_time
	fire_timer = fire_time
	rate_timer = 0
	

func process_physics(delta):
	var direction = (protag.global_position - troop.global_position)/50
	troop.velocity = direction
	
	troop.do_movement(delta)

func process_frame(delta):
	if rev_timer > 0:
		rev_timer -= delta
	else:
		if !continuous:
			shoot()
			transitioned.emit(self, next_state.name)
		else:
			if fire_timer > 0:
				fire_timer -= delta #if you're still firing for X seconds
				if rate_timer > 0:
					rate_timer -= delta
				else:
					shoot()
					rate_timer = fire_rate
			else:
				transitioned.emit(self, next_state.name)

func shoot():
	var projectile = fireball.instantiate()
	owner.get_parent().add_child(projectile)
	projectile.transform = spawn.global_transform
	projectile.spawned()
