extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var default_zoom = 0.65
export var increment_zoom = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = default_zoom*Vector2.ONE



func _on_powerup_hitbox_area_entered(area):
	zoom += increment_zoom*Vector2.ONE
