extends CanvasLayer


var game_scene = preload("res://scenes/game.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		


