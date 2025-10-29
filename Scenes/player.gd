extends Sprite2D

@export var tile_size: float = texture.get_width() * scale.x

@onready var ray_cast: RayCast2D = $RayCast2D

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		ray_cast.rotation = deg_to_rad(180)
	elif event.is_action_pressed("right"):
		ray_cast.rotation = 0
	elif event.is_action_pressed("up"):
		ray_cast.rotation = deg_to_rad(270)
	elif event.is_action_pressed("down"):
		ray_cast.rotation = deg_to_rad(90)
		
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			ray_cast.force_raycast_update()
			if !ray_cast.is_colliding():
				position += inputs[dir] * tile_size
		


func _on_hazard_collision_body_entered(_body: Node2D) -> void:
	get_tree().reload_current_scene()


func _on_blue_collision_body_entered(_body: Node2D) -> void:
	print("blue entered")


func _on_red_collision_body_entered(_body: Node2D) -> void:
	print("red entered")
