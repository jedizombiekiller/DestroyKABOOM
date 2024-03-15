extends GridContainer

@export var ui_sounds : UISounds
@onready var trapper_button = $TrapperButton
@onready var shrubbon_button = $ShrubbonButton
@onready var potbelly_button = $PotbellyButton
@onready var mageshroom_button = $MageshroomButton

func _process(delta):
	if trapper_button.disabled:
		trapper_button.get_node("TextureRect").modulate = Color.BLACK
	else:
		trapper_button.get_node("TextureRect").modulate = Color.WHITE
	
	if shrubbon_button.disabled:
		shrubbon_button.get_node("TextureRect").modulate = Color.BLACK
	else:
		shrubbon_button.get_node("TextureRect").modulate = Color.WHITE
	
	if potbelly_button.disabled:
		potbelly_button.get_node("TextureRect").modulate = Color.BLACK
	else:
		potbelly_button.get_node("TextureRect").modulate = Color.WHITE
	
	if mageshroom_button.disabled:
		mageshroom_button.get_node("TextureRect").modulate = Color.BLACK
	else:
		mageshroom_button.get_node("TextureRect").modulate = Color.WHITE
