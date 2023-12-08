# Documentation développeur


## Nos outils technologiques : 

Godot : Outil concepteur de jeux vidéo  

Itch.io : Hébergement du jeu  

 

## La structure du code : 

# Les fonctions principales :  

## Fonctions des mouvements
```func _process(delta):
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
	position.x += movement #La position du joueur est mise à jour```

## Fonction dégats du mur :
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
