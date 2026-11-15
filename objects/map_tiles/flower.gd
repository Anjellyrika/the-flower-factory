## Flowers must be connected to water to win the level.
## Input from any of four sides
class_name Flower
extends Channel

signal bloomed

@onready var sfx_player: AudioStreamPlayer2D = $SFX
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_bloomed := false


func _ready() -> void:
	animated_sprite.play('wilt')

func get_targets() -> Array[Vector2i]:
	return []


func accepts_water(_water_direction: Vector2i) -> bool:
	return true

# watered flowers stay in bloom
func set_watered(value: bool) -> void:
	super.set_watered(value)
	if value and not is_bloomed:
		is_bloomed = true
		animated_sprite.play("bloom")
		bloomed.emit()
		sfx_player.play()
