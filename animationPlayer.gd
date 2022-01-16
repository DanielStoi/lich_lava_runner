extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var action = 0 # 0= not moving, 1 = right, -1 = left
var dir = 1 #1 = right, -1 = left
var action_frame = 0
var flip = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	action = 0
	if Input.is_action_pressed("ui_left"):
		action -=1
	if Input.is_action_pressed("ui_right"):
		action +=1
	
	if action == 0:
		frame = 0
	elif action != dir:
		frame = 1
		action_frame = 1
		flip = !flip
	else:
		action_frame = (action_frame+1)%2
		frame = action_frame+1
	flip_h = flip
	
	dir = dir if action == 0 else action
