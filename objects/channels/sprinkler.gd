## Sprinklers water the top, left, right, and bottom adjacent cells.
## Input from any of four sides, output on all four sides
extends Channel

@onready var sfx_player: AudioStreamPlayer2D = $SFX


func _exit_tree() -> void:
	SfxPlayer.stop_sprinkler(sfx_player)


func get_targets() -> Array[Vector2i]:
	return [cell + Vector2i.UP, cell + Vector2i.RIGHT,
		cell + Vector2i.DOWN, cell + Vector2i.LEFT]


func accepts_water(_water_direction: Vector2i) -> bool:
	return true


func set_watered(value: bool) -> void:
	if watered == value:
		return
	super(value)
	if watered:
		SfxPlayer.start_sprinkler(sfx_player)
	else:
		SfxPlayer.stop_sprinkler(sfx_player)
