extends Area2D

class_name Boss

var points = 100
@export var speed = 200
@onready var labelScore = $labelScore
@onready var sprite2D = $Sprite2D
var explosion_texture = preload("res://assets/boss/boss-explosion.png")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Laser:
		labelScore.text = str(points)
		speed = 0
		sprite2D.texture = explosion_texture
		await get_tree().create_timer(1).timeout
		sprite2D.visible = false
		labelScore.visible = true
		await get_tree().create_timer(1).timeout
		queue_free()

