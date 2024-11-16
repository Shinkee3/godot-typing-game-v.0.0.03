extends Node

signal TeleportSpell(target_pos: Vector2) ## used by spells: Teleport
## this signal is basically a way for the Teleport spell to call a function in the Player script that does the actual teleporting
## quick analogy of this signal:
"""
Autoload: has a signal named "Email" with parameter "target_pos" of type Vector2
Person A (teleport spell) wants to send an email to Person B (Player)
Person B connects a receiver function for this Email signal named "_teleport_player" that accepts a Vector2 type parameter


Person A emits the Email signal, with parameter: Vector2(10, 20)
Person B receives the signal and the parameter of the signal. Person B then calls the receiver function and does stuff


if Person B (Player) did NOT connect to the signal, it wouldnt do anything even if Person A emitted the signal.

(this is just a quick explanation for signals, it's preferable to watch a more detailed tutorial on signals atleast in the future
since signals are a very important aspect of Godot)
"""

var player_pos: Vector2 ## used by spells: blessed_aura, magic_missile

## NOTE:
"""
## this script is a global singleton aka autoload (check Project > Project Settings > Autoload, then look for PlayerInfo)
## global = every script can reference this singleton
## singleton = only one instance of this script can exist
"""

## Motivation: 
## @onready var player: Player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
"""
it's fine to use get_parent() if you want a child of a node to communicate with its parent, we normally
use this if the parent and the child exist in the same scene (ie, the child is not its own scene, only the parent is the scene)

However for the case of spells that require the player's position, you have to climb up the tree with "get_parent"
to get the reference to the player scene that exists in the "arena_level" scene

An alternative cleaner way of doing this would be to use absolute paths of "get_node"
ALTERNATIVE WAY: 
@onready var player: Player = get_node("/root/arena_level/player")

But the issue with this one, say the player goes to the next level, which is a scene called "arena_level_2"
the absolute path above no longer works since it'd now have to be "/root/arena_level_2/player", but 
the "get_parent().get_parent()..." snake still works

Although the issue with "get_parent().get_parent()..." snake is you'd always have to keep track of how many times it takes
to reach the root node from the spell node. So when you make changes to the ordering of nodes, you may have to go
back to each spell node to change the length of the "get_parent" snake.
"""

## Purpose of this autoload script:
"""
With this singleton, the spells no longer need to reference the player to get the player's position.
The player node can just update the "player_position" variable inside the PlayerInfo singleton
which can be accessed by the spells (and everything else since it's global)

You can also add more variables here incase you want the spells to get other properties of the player
You can also add signals if u want ways for nodes to call functions on the player script
"""
