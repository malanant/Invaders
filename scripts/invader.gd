extends Area2D

class_name Invader

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
var config: Resource

signal invader_destroyed(points: int)

func _ready():
	sprite_2d.texture = config.sprite_1
	animation_player.play(config.animation_name)

func _on_area_entered(area):
	if area is Laser:
		animation_player.play("eleminer")
		get_node("../../player/shooting").laser_destroyed()
		area.queue_free()
		print("Ennemi touché")

func _on_animation_player_animation_finished(animation_player):
	if animation_player == "eleminer":
		queue_free()
		invader_destroyed.emit(config.points)
