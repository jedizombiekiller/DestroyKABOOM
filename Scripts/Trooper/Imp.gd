extends TrooperClass

'''
This is the logic behind the Imp-Like trooper
States: Follow, Fireball, Melee

Follow - Slowly walks towards the protag. 
Every 2 seconds, there's a 50% chance it changes to Fireball
If close enough, transition into melee

Fireball - Imp stands still for 1 second before launching
a fireball at the protag. Once finished, transition back into wander

Melee - Will deal damage to protag until out of range when you
transition into follow
'''
