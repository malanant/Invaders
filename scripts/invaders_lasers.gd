extends Area2D

class_name InvaderLaser

@export var speed = 350

func _process(delta):
	position.y += speed * delta

func _on_area_entered(area):
	if area is Player:
		(area as Player).invader_hit_player()
		queue_free()
