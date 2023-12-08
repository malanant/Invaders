# Documentation développeur


## Nos outils technologiques : 

Godot : Outil concepteur de jeux vidéo  

Itch.io : Hébergement du jeu  

 

## La structure du code : 

# Les fonctions principales :  
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
