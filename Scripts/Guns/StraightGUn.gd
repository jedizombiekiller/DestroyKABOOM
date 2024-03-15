extends RayCast3D
class_name StraightGun

@export var damage_range : Array = [5,15]
@export var fire_rate : float = 0.6
var time : float
@export var active = false
var shooting
var targetted_troop

func activate():
	time = fire_rate
	active = false
	#print("Using " + name)

func deactivate():
	active = false
	#print("No longer using " + name)

func _ready():
	#active = true
	shooting = false

func _process(delta):
	targetted_troop = null
	if active:
		if get_collider():
			if get_collider().is_in_group("Trooper"):
				targetted_troop = get_collider()
				shooting = true
				#get_collider().hurt(1)
				#var rand = randi_range(0, 100)*delta
				#if rand < 1*delta:
					#
				#print("pew")
		else:
			targetted_troop = null
			shooting = false

func _physics_process(delta):
	if time <= 0:
		shoot()
		time = fire_rate
	else:
		time -= delta
	pass

func shoot():
	if is_instance_valid(get_collider()):
		if get_collider() is TrooperClass:
			get_collider().hurt(randi_range(damage_range[0], damage_range[1]))
			$ShotSound.play()
	#print("pew")


func _on_timer_timeout():
	if active and shooting:
		shoot()
	pass # Replace with function body.
