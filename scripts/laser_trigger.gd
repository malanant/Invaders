extends Area2D

func _on_area_entered(area):
	get_parent().get_node("laser").queue_free() #Supprime l'objet laser
	get_parent().get_node("player").get_node("shooting").laser_destroyed()
	
