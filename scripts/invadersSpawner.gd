extends Node2D

class_name invadersSpawner
@onready var shot_timer = $shot
@onready var movement_timer = $mouvementTimer

signal invader_destroyed(points: int)
signal game_end
signal round_won

var rows = 5
var columns = 11
var spacing_x = 32
var spacing_y = 20
var invader_size = 22
var origin_position = -50
var invader_movement_grid_x = 5
var invader_movement_grid_y = 5
var movement = 1
var invader_scene = preload("res://scenes/invader.tscn")
var invader_shot_scene = preload("res://scenes/invaders_lasers.tscn")


var invader_destroyed_count = 0
var invader_total_count = rows * columns


func _ready():
	print(invader_destroyed_count)
	print(invader_total_count)
	movement_timer.timeout.connect(movement_invaders)
	shot_timer.timeout.connect(invader_shot)
	var invader_1_res = preload("res://modules/invader_1.tres")
	var invader_2_res = preload("res://modules/invader_2.tres")
	var invader_3_res = preload("res://modules/invader_3.tres")
	var global_invaders_script
	
	for row in rows:
		if row == 0:
			global_invaders_script = invader_1_res
		elif row == 1 or row == 2:
			global_invaders_script = invader_2_res
		elif row == 3 or row == 4:
			global_invaders_script = invader_3_res
			
		var row_width = (columns * 6 * 3) + ((columns - 1) * spacing_x)
		var origin_x_position = (position.x - row_width) / 2
		
		for colomn in columns:
			
			var x = origin_x_position + (colomn * 6 * 3) + (colomn * spacing_x)
			var y = origin_position + (row * invader_size) + (row * spacing_y)
			
			var spawn_position = Vector2(x, y)
			spawn_invader(global_invaders_script, spawn_position)
	
func spawn_invader(global_invaders_script, spawn_position:Vector2):
	var invader = invader_scene.instantiate() as Invader
	invader.config = global_invaders_script
	invader.global_position = spawn_position
	invader.invader_destroyed.connect(on_invader_destroyed)
	add_child(invader)

func movement_invaders():
	if	invader_destroyed_count > 15:
		invader_movement_grid_x = 9 
	if invader_destroyed_count > 10:
		invader_movement_grid_x = 12
	if invader_destroyed_count > 15:
		invader_movement_grid_x = 15
	if invader_destroyed_count > 20:
		invader_movement_grid_x = 17
	if invader_destroyed_count > 25:
		invader_movement_grid_x = 20
	

	position.x += invader_movement_grid_x * movement
	print(position.x)	
func _on_triggers_gauche_area_entered(area):
	if (movement == -1):
		position.y += invader_movement_grid_y
		movement *= -1


func _on_triggers_droite_area_entered(area):
	if (movement == 1):
		position.y += invader_movement_grid_y
		movement *= -1
		
func invader_shot():
	var random_child_position = get_children().filter(func (child): return child is Invader).map(func (invader): return invader.global_position).pick_random()
	var invader_laser = invader_shot_scene.instantiate() as InvaderLaser
	invader_laser.global_position = random_child_position
	get_tree().root.add_child(invader_laser)

func on_invader_destroyed(points: int):
	invader_destroyed.emit(points)
	invader_destroyed_count += 1
	
	if invader_destroyed_count == invader_total_count:
		round_won.emit()
		shot_timer.stop()
		movement_timer.stop()
	print(points)



func _on_triggers_bas_area_entered(area):
	if(area is Invader):
		movement = 0
		game_end.emit()

	else:
		area.queue_free()
