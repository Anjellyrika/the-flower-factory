## Wheelbarrows carry water forward after a short "filling time" delay and can be rotated.
## Input on one side, output on the opposite side
## Interact to adjust the rotation
extends Channel

@onready var sfx_player: AudioStreamPlayer2D = $SFX

func interact() -> void:
	rotate_clockwise()
	sfx_player.play()


func rotate_clockwise() -> void:
	rotation += PI / 2.0
	changed.emit()
