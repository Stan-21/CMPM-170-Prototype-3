extends Node2D

#----RULES----

const minInput = 3
const maxInput = INF

const blueSafe = true
const redSafe = true

const leftSafe = true
const rightSafe = true
const upSafe = true
const downSafe = true

#----TRACKER----

var inputCounter = 0

var leftInput = 0
var rightInput = 0
var upInput = 0
var downInput = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_inputed():
	inputCounter += 1


func _on_player_flag_entered():
	print(inputCounter, minInput)
	if (inputCounter <= minInput) or (inputCounter > maxInput):
		get_tree().reload_current_scene()
		print("died")
	else:
		print("not died")


func _on_player_blue_entered():
	if !blueSafe:
		get_tree().reload_current_scene()


func _on_player_red_entered():
	if !redSafe:
		get_tree().reload_current_scene()
