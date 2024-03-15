extends VBoxContainer

@export var game_scene : GameScene
@export var protag : Protagonist
@onready var progress = $BottomHalf/ProtagView/SubViewport/ProgressBar
@onready var energy = $TopHalf/Left/Control/Label
@onready var shop = $TopHalf/Left/Shop
@onready var palette = $TopHalf/Right/Palette

@onready var UI_Head = $BottomHalf/ProtagView/SubViewport/Head/TextureRect/HeadSprite

var is_on_final_room 

func _ready():
	is_on_final_room = false

func _process(delta):
	#$BottomHalf/ProtagView/SubViewport/State.text = str(protag.state_machine.current_state)
	debug_UI()
	game_scene.current_troop_selected = palette.current_troop_selected
	update_energy_text()
	update_palette()
	update_shop()
	do_head_anim()

func do_head_anim():
	var health : float = protag.health / 100.0#(4 * 25) #to make it max 100 and then divide it by 4
	#print(health)
	if health >= 3:
		UI_Head.frame = 0
	elif health >= 2:
		UI_Head.frame = 1
	elif health >= 1:
		UI_Head.frame = 2
	elif health > 0:
		UI_Head.frame = 3
	elif health <= 0:
		UI_Head.frame = 4
	else:
		UI_Head.frame = 0
	

func debug_UI():
	match protag.current_gun:
		0:
			$BottomHalf/ProtagView/SubViewport/State.text = "Pistol"
		1:
			$BottomHalf/ProtagView/SubViewport/State.text = "Shotgun"
		2:
			$BottomHalf/ProtagView/SubViewport/State.text = "Chaingun"
		_:
			$BottomHalf/ProtagView/SubViewport/State.text = "No"
	$BottomHalf/ProtagView/SubViewport/Health.text = "Health:" + str(round(protag.health/4))
	$BottomHalf/ProtagView/SubViewport/Mag.text = "Mag:" + str(protag.ammo_mag)
	$BottomHalf/ProtagView/SubViewport/Shell.text = "Shell:" + str(protag.ammo_shell)

var boss #= get_tree().get_first_node_in_group("Boss")
func update_energy_text():
	var computer = game_scene.current_computer
	if is_on_final_room:
		boss = get_tree().get_first_node_in_group("Boss")
		#print("FINAL BOSS!!!!!!!!!!!!!!!")
		progress.set_value_no_signal(boss.health)
		progress.max_value = boss.troopResource.health
		
	else:
		#print("NORMAL!!!!!!!!!!!!!!!!!")
		if computer:
			progress.set_value_no_signal(computer.loading)
	
	energy.text = "Energy: " + str(GameManager.energy)

func update_palette():
	var trooper_button = [
		palette.trapper,
		palette.shrubbon,
		palette.potbelly,
		palette.mageshroom
	]
	var trooper_labels = [
		trooper_button[0].get_node("Label"),
		trooper_button[1].get_node("Label"),
		trooper_button[2].get_node("Label"),
		trooper_button[3].get_node("Label")
	]
	for i in game_scene.amount_of_troop.size():
		if game_scene.amount_of_troop[i] <= 0:
			trooper_button[i].disabled = true
		else:
			trooper_button[i].disabled = false
		if trooper_button[i].button_pressed:
			if palette.current_troop_selected != i:
				trooper_button[i].button_pressed = false
		trooper_labels[i].text = "x" + str(game_scene.amount_of_troop[i]).pad_zeros(2)

func update_shop():
	var trooper_button = [
		shop.trapper_button,
		shop.shrubbon_button,
		shop.potbelly_button,
		shop.mageshroom_button
	]
	'''
	For every button
	check if current energy is over trooper price (from scene)
	activate button if so
	deactivate it if no
	'''
	
	for i in trooper_button.size():
		if GameManager.energy >= game_scene.troopPrice[i]:
			trooper_button[i].disabled = false
		else:
			trooper_button[i].disabled = true

func _trapper_buy():
	game_scene.ui_sounds.buy_sound()
	game_scene.amount_of_troop[0] += 1
	GameManager.energy -= game_scene.troopPrice[0]
	pass # Replace with function body.

func _shrubon_buy():
	game_scene.ui_sounds.buy_sound()
	game_scene.amount_of_troop[1] += 1
	GameManager.energy -= game_scene.troopPrice[1]
	pass # Replace with function body.

func _potbelly_buy():
	game_scene.ui_sounds.buy_sound()
	game_scene.amount_of_troop[2] += 1
	GameManager.energy -= game_scene.troopPrice[2]
	pass # Replace with function body.

func _mageshroom_buy():
	game_scene.ui_sounds.buy_sound()
	game_scene.amount_of_troop[3] += 1
	GameManager.energy -= game_scene.troopPrice[3]
	pass # Replace with function body.


func _on_protag_protag_death():
	$BottomHalf/ProtagView/SubViewport/ColorRect/DeathAnim.play("death")
	pass # Replace with function body.


func _on_game_scene_final_room():
	
	is_on_final_room = true
	pass # Replace with function body.
