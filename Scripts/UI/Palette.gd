extends HBoxContainer

@onready var ui_sounds = $"../../../../UISounds" #this is BAD never do this again
@onready var trapper = $SelectTrapper
@onready var shrubbon = $SelectShrubbon
@onready var potbelly = $SelectPotbelly
@onready var mageshroom = $SelectMageshroom

@export var disable_color : Color

var current_troop_selected : int = -1

func _process(delta):
	if trapper.disabled:
		trapper.get_node("Icon").modulate = disable_color
	else:
		trapper.get_node("Icon").modulate = Color.WHITE
	
	if shrubbon.disabled:
		shrubbon.get_node("Icon").modulate = disable_color
	else:
		shrubbon.get_node("Icon").modulate = Color.WHITE
	
	if potbelly.disabled:
		potbelly.get_node("Icon").modulate = disable_color
	else:
		potbelly.get_node("Icon").modulate = Color.WHITE
	
	if mageshroom.disabled:
		mageshroom.get_node("Icon").modulate = disable_color
	else:
		mageshroom.get_node("Icon").modulate = Color.WHITE

func _on_select_trapper_pressed():
	ui_sounds.choose_sound()
	current_troop_selected = 0
	pass # Replace with function body.


func _on_select_shrubbon_pressed():
	ui_sounds.choose_sound()
	current_troop_selected = 1
	pass # Replace with function body.


func _on_select_potbelly_pressed():
	ui_sounds.choose_sound()
	current_troop_selected = 2
	pass # Replace with function body.


func _on_select_mageshroom_pressed():
	ui_sounds.choose_sound()
	current_troop_selected = 3
	pass # Replace with function body.
