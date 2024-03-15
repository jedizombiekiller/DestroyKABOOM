extends CharacterBody3D
class_name TrooperClass

#@onready var spawner = get_node("../Spawner")
#here are the variables that every trooper needs???

@export var troopResource: TroopResource
@export var loot : Array[PackedScene] = []
@export_range(0,100) var drop_percent : int = 50
@export var sound_manager : SoundManager

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health : int
var protag : CharacterBody3D
var explosion = preload("res://Scenes/Effects/explosion.tscn")

func _ready():
	protag = get_tree().get_first_node_in_group("Protag") #make sure protag is in group
	health =  troopResource.health
	set_global_position(get_parent().spawn_pos) #this spawns you at the spawn position gathered from the parent

func _physics_process(delta):
	if health <= 0:
		death()
	if global_position.y < -50:
		queue_free()
	pass

func do_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	var lookdir = atan2(-velocity.x, -velocity.z)
	rotation.y = lookdir
	move_and_slide()

func hurt(damage):
	sound_manager.play_hurt()
	health -= damage
	#print("ouch " + str(health))
	pass

func death():
	protag.kill_count += 1
	spawn_explosion()
	drop_item()
	queue_free()

func spawn_explosion():
	var explode = explosion.instantiate()
	get_parent().add_child(explode)
	explode.global_position = global_position
	#explode.global_position.y += 1

func drop_item():
	var chance = randi_range(0,100)
	if chance <= drop_percent:
		if !loot.is_empty():
			#var rand_item = randi_range(0,loot.size())
			var item = loot.pick_random().instantiate()
			get_parent().add_child(item)
			item.global_position = global_position
			item.global_position.y += 1
