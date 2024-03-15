extends TrooperState
class_name TroopFollow

@export var run_away : bool = false
@export var action_time : float = 1.5 # how much time inbetween each action
@export var act_percent : int
#@export var attack_on_sight : bool = true # should they attack if close enough?
@export var start_with_action : bool = true
var act_timer : float

func enter():
	troop.sound_manager.play_idle()
	if start_with_action:
		act_timer = 0
	else:
		act_timer = action_time
	pass
	super() #runs the parent method i think

func process_physics(delta):
	var direction = protag.global_position - troop.global_position
	if run_away:
		direction *= -1
	if direction.length() < troop.troopResource.follow_dist:
		if next_state_close: #if it exists
			transitioned.emit(self, next_state_close.name) # should transition to melee
	else:
		troop.velocity = direction.normalized() * troop.troopResource.speed
		
	troop.do_movement(delta)

func process_frame(delta):
	if action_time > 0: #means you can set action time to a negative to disable it
		if act_timer > 0:
			act_timer -= delta
		else:
			var result = randi_range(0,100)
			if result <= act_percent:
				if next_state:
					transitioned.emit(self, next_state.name)
			else:
				act_timer = action_time
	pass

func exit():
	pass
