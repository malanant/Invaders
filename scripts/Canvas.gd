extends CanvasLayer

var life_texture = preload("res://assets/player/Player.png")
@onready var lifes_container = $VBoxContainer/HBoxContainer
@onready var pointsLabel = $MarginContainer/points

@onready var gameOverLabel = $gameOver
@onready var points_counter = $"../pointCounter" as PointsCounter
@onready var player_lifes = $"../playerLife" as PlayerLife
@onready var invader_spawner = $"../invadersSpawner"
# Called when the node enters the scene tree for the first time.
func _ready():
	pointsLabel.text = str(0)
	points_counter.on_points_increased.connect(points_increased)
	print("Test : Chargement CanvasLayer")
	
	for life in range(player_lifes.lifes):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.custom_minimum_size = Vector2(40, 25)
		life_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		life_texture_rect.texture = life_texture
		lifes_container.add_child(life_texture_rect)

func game_end():
	gameOverLabel.visible = true
	
func points_increased(points: int):
	pointsLabel.text = str(points)
	
func on_life_loft(lifes_left: int):
	print(lifes_left)
	if lifes_left !=0:
		var life_texture_rect = lifes_container.get_child(lifes_left)
		life_texture_rect.queue_free()
	else:
		game_end()

