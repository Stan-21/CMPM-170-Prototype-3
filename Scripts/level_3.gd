extends Node2D

#----RULES----

const minInput = 0
const maxInput = INF

const blueSafe = true
const redSafe = false

const leftSafe = INF
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
	$Node2D/Player.queue_free()
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
		death()


func _on_player_flag_entered():
	if (inputCounter <= minInput) or (inputCounter > maxInput):
		death()
	elif (inputCounter % 2 > 0):
		$VBoxContainer/Label3.add_theme_color_override("font_color", "red")
		$VBoxContainer/Label4.add_theme_color_override("font_color", "red")
		print("here")
		death()
	else:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/start.tscn")


func _on_player_blue_entered():
	if !blueSafe:
		death()


func _on_player_red_entered():
	if !redSafe && (inputCounter % 2 > 0):
		$VBoxContainer/Label.add_theme_color_override("font_color", "red")
		death()
 
