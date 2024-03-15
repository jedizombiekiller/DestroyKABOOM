extends State
class_name TrooperState

@export var troop : TrooperClass 
@export var next_state_close : TrooperState # What state to go to when near player
@export var next_state_far : TrooperState # What state to go to when far from player
@export var next_state : TrooperState # Next state for general purposes
var protag : CharacterBody3D

func enter():
	protag = get_tree().get_first_node_in_group("Protag") #make sure protag is in group
	if !troop:
		print("Warning: Trooper is not set for " + self.name)
	pass
