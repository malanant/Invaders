extends Area2D

@export var sprite:Sprite2D
@export var texture_array: Array[Texture2D]

var damage = 0
const type = 2	

# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is Laser :
		area.queue_free()
		print(get_node("../../player/shooting").laser_destroyed())
	elif area is InvaderLaser:
		area.queue_free()
	if damage < type and type  > 0:
		damage += 1
		sprite.texture = texture_array[damage - 1]
	else:
		queue_free()	
	if area is Invader:
		queue_free()
