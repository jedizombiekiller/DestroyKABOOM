extends CharacterBody3D
class_name Fireball

@export var speed : float = 5.0
@export var damage : int = 5
@export var lifespan : float = 10.0
var protag : CharacterBody3D
var direction : Vector3
@onready var hitbox = $Hitbox

func spawned():
	$AudioStreamPlayer3D.pitch_scale = randf_range(0.8,1.2)
	protag = get_tree().get_first_node_in_group("Protag")
	direction = protag.global_position - global_position
	

func _physics_process(delta):
	velocity = direction.normalized() * speed
	move_and_slide()

func _process(delta):
	if lifespan > 0:
		lifespan -= delta
	else:
		queue_free()


func _on_hitbox_body_entered(body):
	if body is Protagonist:
		body.hurt(damage)
	queue_free()
	pass # Replace with function body.
