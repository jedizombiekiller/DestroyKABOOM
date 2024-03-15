extends Label

@export var protag : Protagonist
@export var type : int = 0 
'''
0 - Energy
1 - Health
'''

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match type:
		0:
			text = "Energy: " + str(GameManager.energy)
		1:
			text = "Health: " + str(protag.health)
		_:
			text = "no"
	pass
