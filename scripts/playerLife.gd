extends Node

class_name PlayerLife
signal life_lost(life_left: int)

@export var lifes = 3
@onready var player: Player = $"../player"
var player_scene = preload("res://scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	(player as Player).player_hit.connect(on_player_destroyed)

func on_player_destroyed():
	lifes-=1
	life_lost.emit(lifes)
	if lifes !=0:
		player = player_scene.instantiate() as Player
		player.global_position = Vector2(0, 268)
		player.player_hit.connect(on_player_destroyed)
		get_tree().root.get_node("game").add_child(player)
