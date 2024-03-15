extends Camera3D

var protag : CharacterBody3D

func _ready():
	#get_tree().call_group("3dSprite", "set_camera", self)
	protag = get_tree().get_first_node_in_group("Protag") #make sure protag is in group

func _process(delta):
	get_tree().call_group("3dSprite", "set_camera", self)
	position = protag.global_position
	rotation.y = protag.rotation.y
	#rotate_y(delta)
	pass
