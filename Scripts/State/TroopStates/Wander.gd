extends TrooperState
class_name TroopWander

@export var wander_time_range : Vector2 = Vector2(1,3)
@export var action_time : float = 1
@export var act_percent : int
@export var attack_on_sight : bool = true
@export var start_with_action : bool = true
var wander_time : float
var act_timer : float


func enter():
	super()
	if start_with_action:
		act_timer = 0
	else:
		act_timer = action_time
	pass
	randomize_velocity()

func process_physics(delta):
	troop.do_movement(delta)
	pass

func process_frame(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_velocity()
	
	var direction = protag.global_position - troop.global_position
	if direction.length() < troop.troopResource.follow_dist:
		if attack_on_sight:
			transitioned.emit(self, next_state_close.name) # should transition to melee
	
	if act_timer > 0:
		act_timer -= delta
	else:
		var result = randi_range(0, 100) # out of 100 percent
		if result <= act_percent: # if the number you roll is below percent, change state
			#print("pew")
			transitioned.emit(self, next_state.name)
		else:
			act_timer = action_time
		troop.do_movement(delta)

func exit():
	pass

func randomize_velocity():
	troop.velocity.x = randf_range(-troop.troopResource.speed,troop.troopResource.speed)
	troop.velocity.z = randf_range(-troop.troopResource.speed,troop.troopResource.speed)
	wander_time = randf_range(wander_time_range.x,wander_time_range.y)
