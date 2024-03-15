extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {} #this will hold all of the states. learn more about dictionaries

func _ready():
	for child in get_children(): #woah i didn't even know you could say "get children"
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _physics_process(delta):
	if current_state:
		current_state.process_physics(delta)

func _process(delta):
	if current_state:
		current_state.process_frame(delta)

func on_child_transition(state, new_state_name):
	if state != current_state: # if the state your calling from is not the current state, you did something wrong
		return
	
	var new_state = states.get(new_state_name.to_lower()) #make sure your states are all lowercase
	if !new_state: #sometimes new_state has wrong name, so exit if so
		return
	
	if get_parent() is Protagonist: #Memento Mori, you cannot escape death
		if state.name == "Die":
			return
	
	if current_state: # exit the current state
		current_state.exit()
	
	new_state.enter() # enter the new state
	current_state = new_state #update the current state
