extends Sprite2D

@export var tile_size: float = texture.get_width() * scale.x

@onready var ray_cast: RayCast2D = $RayCast2D

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

signal inputed(dir)
signal flag_entered
signal blue_entered
signal red_entered

signal booster_entered(dir)

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
			move(dir)
			inputed.emit(dir)
		
func move(dir):
	ray_cast.force_raycast_update()
	if !ray_cast.is_colliding():
		position += inputs[dir] * tile_size

func _on_hazard_collision_body_entered(_body: Node2D) -> void:
	get_tree().reload_current_scene()


func _on_blue_collision_body_entered(_body: Node2D) -> void:
	blue_entered.emit()


func _on_red_collision_body_entered(_body: Node2D) -> void:
	red_entered.emit()


func _on_flag_collision_body_entered(_body: Node2D):
	flag_entered.emit()


func _on_right_booster_body_entered(body):
	ray_cast.rotation = 0
	move("right")
	move("right")


func _on_up_booster_body_entered(body):
	ray_cast.rotation = 270
	move("up")
	move("up")


func _on_left_booster_body_entered(body):
	ray_cast.rotation = 180
	move("left")
	move("left")


func _on_down_booster_body_entered(body):
	ray_cast.rotation = 90
	move("down")
	move("down")
