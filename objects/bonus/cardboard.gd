extends Bonus

@onready var sprite_state = $AnimatedSprite2D

func _ready() -> void:
	sprite_state.play("upturned")

func interact() -> void:
	if (sprite_state.animation == 'fixed'):
		return
	sprite_state.play("fixed")
	sprite_state.rotation = 0.0 # TODO: Remove when finalized assets
	bonus_unlocked.emit()
