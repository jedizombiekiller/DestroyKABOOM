extends TrooperClass

'''
This is the logic behind the Mushroom Mage trooper
States: Wander, Melee, Teleport

Wander - Slowly walks around
Every 1 seconds, there's a 50% chance it changes to Melee
If protag gets close enough, transition into teleport

Melee - Starts attacking every 1.5 seconds. With each attack,
there's a 20% chance it transitions back into wander
If protag gets close enough, transition into teleport

Teleport - Stands still for 2 seconds until grabbing a random location
from a range far enough from the player and with ground, then teleporting there.
Transitions into Wander after this
''' 

@export var teleport_range = 30

@onready var pointer_col = $TeleportPointer/CollisionShape3D
var pos_found = false

func _ready():
	super()
	pointer_col.disabled = true
