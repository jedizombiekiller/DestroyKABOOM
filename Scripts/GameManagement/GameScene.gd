extends Node3D
class_name GameScene

signal final_room
signal progressed(room)
var in_final_room : bool = false
#nodes we need access to
@onready var energy_timer = $EnergyTimer
@onready var screen_fade = $CanvasLayer/ScreenFade
@onready var dialogue = $Dialogue
@onready var ui_sounds : UISounds = $UISounds
#export variables
@export var starting_energy = 0
@export var troopPrice = [ # price of each trooper
	20,
	40,
	60,
	80,
	0,
	0
]
var troopFile # holds all the troop files. ignore the fact it isn't plural 
var spawn_pos : Vector3 #position of the spawner
var progress : int = 0 # starts at 0 and goes up to 3 which is the final room
@export var current_computer : Computer
@export var go_here : Node3D
@export var minimap : Camera3D
@export var protag : Protagonist
@export var code_speed : float = 2
var amount_of_troop : Array[int] = [0, 0, 0, 0]
var current_troop_selected : int

# Called when the node enters the scene tree for the first time.
func _ready():
	troopFile = [
		load("res://Scenes/Troopers/Types/VenusTrap.tscn"),
		load("res://Scenes/Troopers/Types/Imp.tscn"),
		load("res://Scenes/Troopers/Types/Potbelly.tscn"),
		load("res://Scenes/Troopers/Types/Archville.tscn"),
		
		load("res://Scenes/Troopers/trooper.tscn"),
		load("res://Scenes/Troopers/red_trooper.tscn"),
		load("res://Scenes/Troopers/Types/Building.tscn") #6
	]
	$CanvasLayer.show()
	GameManager.energy = starting_energy
	energy_timer.start()
	current_computer.activate()
	
	#dialogue stuff
	dialogue.active = Settings.show_dialogue
	dialogue.talk1()

func talk(progress : String):
	var talk_script = load("res://Dialogue/main.dialogue")
	DialogueManager.show_dialogue_balloon(talk_script, progress)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#manages computer stuff!!!!!! CODE
	if current_computer:
		if protag.do_code:
			current_computer.loading += code_speed * delta
	
	if progress == 3 and !in_final_room: #final room stuff
		emit_signal("final_room")
		spawn_buildng()
		in_final_room = true

func change_progress(value):
	progress += value
	emit_signal("progressed", progress)

func _input(event): #this is for spawning troopers through the minimap
	if event.is_action_pressed("Click"):
		if current_troop_selected >= 0 and amount_of_troop[current_troop_selected] > 0:
			var result = minimap.shoot_ray()
			if !result.is_empty():
				spawn_pos = result["position"]
				#spawn_pos.y += 1
				amount_of_troop[current_troop_selected] -= 1
				spawn(current_troop_selected)
				ui_sounds.bloop_sound()

func spawn(index : int):
	var trooper = troopFile[index].instantiate()
	add_child(trooper)
	trooper.global_position.y += 1

func spawn_buildng():
	var trooper = troopFile[6].instantiate()
	add_child(trooper)

func _on_yellow_button_down():
	spawn(0)


func _on_red_button_down():
	spawn(1)


func _on_energy_timer_timeout():
	GameManager.add_energy(5)


func _on_valid_tp_request(area):
	if area.is_in_group("teleport_pointer"):
		area.get_parent().pos_found = true


func _on_protag_boss_defeat():
	screen_fade.play_animation("FadeOutWhite")
	pass # Replace with function body.

var lose_scene = load("res://Scenes/UI/LoseScreen.tscn")
var win_scene = load("res://Scenes/UI/WinScreen.tscn")

func to_scene(scene : String): #make this Win or Lose
	match scene:
		"lose":
			get_tree().change_scene_to_packed(lose_scene)
		"win":
			get_tree().change_scene_to_packed(win_scene)
		_:
			return
	pass
