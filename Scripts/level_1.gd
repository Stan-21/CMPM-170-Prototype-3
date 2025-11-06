extends Node2D

#----RULES----

const minInput = 3
const maxInput = INF

const blueSafe = true
const redSafe = true

const leftSafe = 0
const rightSafe = INF
const upSafe = INF
const downSafe = INF

#----TRACKER----

var inputCounter = 0

var leftCounter = 0
var rightCounter = 0
var upCounter = 0
var downCounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func death():
	$Player.queue_free()
	$Windego.visible = true
	await get_tree().create_timer(1).timeout
	get_tree().call_deferred("reload_current_scene")
	print("died")


func _on_player_inputed(dir):
	inputCounter += 1
	if dir == "left":
		leftCounter += 1
	elif dir == "right":
		rightCounter += 1
	elif dir == "up":
		upCounter += 1
	elif dir == "down":
		downCounter += 1
		
	$Steps.text = "Steps: " + str(inputCounter)
	
	if (leftCounter > leftSafe) or (rightCounter > rightSafe) or (upCounter > upSafe) or (downCounter > downSafe):
		$VBoxContainer/Label2.add_theme_color_override("font_color", "red")
		death()

func _on_player_flag_entered():
	if (inputCounter <= minInput) or (inputCounter > maxInput):
		$VBoxContainer/Label1.add_theme_color_override("font_color", "red")
		death()
	else:
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_player_blue_entered():
	if !blueSafe:
		get_tree().call_deferred("reload_current_scene")


func _on_player_red_entered():
	if !redSafe:
		get_tree().call_deferred("reload_current_scene")
