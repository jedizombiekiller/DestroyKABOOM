extends ColorRect

@export var opening_animation : String
@onready var animation_player = $AnimationPlayer

func _ready():
	play_animation(opening_animation)

func play_animation(anim):
	if animation_player.has_animation(anim):
		animation_player.play(anim)


func _on_protag_protag_death():
	play_animation("ProtagDied")
	pass # Replace with function body.
