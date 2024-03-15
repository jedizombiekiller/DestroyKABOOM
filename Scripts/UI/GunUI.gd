extends CanvasLayer

@export var protag : Protagonist
@onready var anim = $AnimationPlayer
var is_shooting = false

func _process(delta):
	match protag.current_gun: #0 - revolver, 1 - shotgun, 2 - AK-47
		0:
			if is_shooting:
				anim.play("RevolverFire")
			else:
				anim.play("Revolver")
		1:
			if is_shooting:
				anim.play("ShotgunFire")
			else:
				anim.play("Shotgun")
		2:
			if is_shooting:
				anim.play("AK47Fire")
			else:
				anim.play("AK47")
		_:
			anim.play("RESET")
	pass

func shooting_done():
	is_shooting = false

func _on_protag_protag_death():
	visible = false
	pass # Replace with function body.


func _on_protag_bullet_shot():
	is_shooting = true
	pass # Replace with function body.
