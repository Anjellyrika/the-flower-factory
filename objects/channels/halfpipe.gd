extends Channel

const EMPTY = preload("res://assets/art/pipe-empty.png")
const FULL = preload("res://assets/art/pipe-full.png")

@onready var sprite: Sprite2D = $Sprite2D


func set_watered(value: bool) -> void:
	if watered == value:
		return
	super(value)
	sprite.texture = FULL if watered else EMPTY
	sprite.self_modulate = Color.WHITE
