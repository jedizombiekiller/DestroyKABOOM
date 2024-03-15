extends TrooperClass

'''
This is the logic behind the Trapper trooper
States: Wander, Follow, Melee

Wander - Goes to a random position on screen.
Every 1.5 seconds, there's a 50% chance it changes to...

Follow - lunges towards the protag for 1 second. Once close enough, transition into...

Melee - deals damage to the protag until out of range
When that happens, transition back into wander
'''
