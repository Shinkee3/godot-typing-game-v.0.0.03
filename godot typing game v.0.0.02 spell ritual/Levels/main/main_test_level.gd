extends Node2D
class_name MainTestLevel 
## ideally u have a dedicated base clas for level named "Level",
## tho for now ill use specific class names just to let godot's autocomplete feature work

"""
purpose of this script: make it easier for "main.gd" to store references to nodes
that other scenes in Main needs (ex, UI)
"""

@onready var player: Player = $Player
