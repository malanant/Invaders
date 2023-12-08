extends Node2D

@onready var spawnTimer = $spawnTimer
@export var boss_scene: PackedScene = preload("res://scenes/boss.tscn")

func _ready():
	(spawnTimer as SpawnTimer).setup_timer()

func _on_spawn_timer_timeout():
	var boss = boss_scene.instantiate()
	boss.global_position = position
	get_tree().root.add_child(boss)
