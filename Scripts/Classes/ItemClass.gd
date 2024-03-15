extends CharacterBody3D
class_name Item

var lifetime = 15

'''
We need this to be able to detect collision
Then, change a value connected to the player
and delete itself
'''

# Called when the node enters the scene tree for the first time.
func _process(delta):
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= 1
	move_and_slide()
	pass

func change_player_value(body):
	pass

func delete():
	queue_free()

func body_entered(body):
	if body is Protagonist:
		change_player_value(body)
		delete()
	pass # Replace with function body.
