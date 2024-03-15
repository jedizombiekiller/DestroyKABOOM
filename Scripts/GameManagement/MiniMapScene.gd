extends Node3D

@export var main_scene : Node3D
var current_room = 0
@onready var room1 = $Room1
@onready var room2 = $Room2
@onready var room3 = $Room3
@onready var room4 = $Room4

@onready var roomcol1 = $ValidAreas/RoomCollision1
@onready var roomcol2 = $ValidAreas/RoomCollision2
@onready var roomcol3 = $ValidAreas/RoomCollision3
@onready var roomcol4 = $ValidAreas/RoomCollision4

func _process(delta):
	if main_scene:
		current_room = main_scene.progress
	
	#if anyone sees this on github: yes i know this is a dumb way to code this lmao i am runnning out of time pls don't judge
	match current_room: #controls the visibility of each Room
		0:
			room1.visible = true
			room2.visible = false
			room3.visible = false
			room4.visible = false
		1:
			room1.visible = false
			room2.visible = true
			room3.visible = false
			room4.visible = false
		2:
			room1.visible = false
			room2.visible = false
			room3.visible = true
			room4.visible = false
		3:
			room1.visible = false
			room2.visible = false
			room3.visible = false
			room4.visible = true
		_:
			room1.visible = true
			room2.visible = true
			room3.visible = true
			room4.visible = true
	
	if room1.is_visible_in_tree():
		roomcol1.disabled = false
	else:
		roomcol1.disabled = true
	
	if room2.is_visible_in_tree():
		roomcol2.disabled = false
	else:
		roomcol2.disabled = true
	
	if room3.is_visible_in_tree():
		roomcol3.disabled = false
	else:
		roomcol3.disabled = true
	
	if room4.is_visible_in_tree():
		roomcol4.disabled = false
	else:
		roomcol4.disabled = true


func _on_valid_areas_area_entered(area):
	print("yes")
	if area.is_in_group("teleport_pointer"):
		area.get_parent().pos_found = true
