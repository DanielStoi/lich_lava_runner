extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var MOVE_SPEED = 400
var JUMP_FORCE = 545
var GRAVITY = 100
var MAX_FALL_SPEED = 10000
var REDUCED_GRAVITY = 60

var y_vel = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	var new_vel = move_and_slide(Vector2(move_dir * MOVE_SPEED,y_vel),Vector2.UP)
	y_vel= new_vel.y
	
	play_animations(new_vel)

func reset_game():
	get_tree().reload_current_scene()


func _on_Hurtbox_area_entered(area):
	reset_game()


func _on_powerup_hitbox_area_entered(area):
	JUMP_FORCE+=56
	MOVE_SPEED+=50

func play_animations(vel):
	if vel.x > 0:
		$Lich.flip_h = false
		$AnimationPlayer.play("walk  right")
	elif vel.x < 0:
		$Lich.flip_h = true
		$AnimationPlayer.play("walk left")
	else:
		$AnimationPlayer.play("RESET")
	
	
