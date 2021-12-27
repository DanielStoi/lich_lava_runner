extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var MOVE_SPEED = 500
var JUMP_FORCE = 1000
var GRAVITY = 100
var MAX_FALL_SPEED = 10000
var REDUCED_GRAVITY = 60

var y_vel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	
	var grounded = is_on_floor()
	y_vel += GRAVITY
	if Input.is_action_pressed("ui_up"):
		y_vel -= REDUCED_GRAVITY
		
	if grounded and Input.is_action_pressed("ui_up"):
		y_vel = -JUMP_FORCE
	if grounded and y_vel > 0:
		y_vel = 0
	if y_vel > MAX_FALL_SPEED:
		y_vel = MAX_FALL_SPEED
	var new = move_and_slide(Vector2(move_dir * MOVE_SPEED,y_vel),Vector2.UP)
	y_vel= new.y

func reset_game():
	get_tree().reload_current_scene()


func _on_Hurtbox_area_entered(area):
	reset_game()


func _on_powerup_hitbox_area_entered(area):
	JUMP_FORCE+=50
	MOVE_SPEED+=50
	
