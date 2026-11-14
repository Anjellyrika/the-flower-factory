## Flowers must be connected to water to win the level.
## Input from any of four sides
extends Channel
# TODO: Make Flower class

signal bloomed

var is_bloomed := false


func get_targets() -> Array[Vector2i]:
	return []


func accepts_water(_water_direction: Vector2i) -> bool:
	return true

# watered flowers stay in bloom
func set_watered(value: bool) -> void:
	super.set_watered(value)
	if value and not is_bloomed:
		is_bloomed = true
		bloomed.emit()
