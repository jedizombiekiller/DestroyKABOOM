extends State
class_name ProtagState

@export var protag : Protagonist 
@export var next_state : ProtagState # Next state for general purposes
@export var next_action_state : ProtagState # The action 

func enter():
	pass

func exit():
	pass

func process_frame(delta):
	pass

func process_physics(delta):
	pass

#thank you Bitlytic
#https://youtu.be/ow_Lum-Agbs?si=YI8-mC16GTpQoF9y
