extends Area2D

class_name Player

signal player_hit
@export var speed = 225
@onready var collistion_rect: CollisionShape2D = $CollisionShape2D
@onready var animationPlayer = $AnimationPlayer

var direction = Vector2.ZERO #La direction du joueur est par défaut zero (soit aucune touche presé)

var collision_size
var collision_left
var collision_right

func _ready():
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_x = camera.position.x
	
	collision_size = collistion_rect.shape.get_rect().size.x
	collision_left = (camera_x - rect.size.x) / 2
	collision_right = (camera_x + rect.size.x) / 2
	

func _process(delta):
	var input = Input.get_axis("left", "right") #Les contrôles sont déterminé dans les paramètres du projet
	var movement = speed * direction.x * delta #Détermine la vitesse du joueur en fonction du framerates
	
	#Détermine la direction en fonction de la touche pressé sur le clavier
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	if(position.x + movement < collision_left + collision_size * transform.get_scale().x or position.x + movement > collision_right - collision_size * transform.get_scale().x):
		return
	
	position.x += movement #La position du joueur est mise à jour
	
func invader_hit_player():
	speed = 0
	animationPlayer.play("hit")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == ("hit"):
		await get_tree().create_timer(1).timeout
		player_hit.emit()
		queue_free()
