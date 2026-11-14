## Sprinklers water the top, left, right, and bottom adjacent cells.
## Input from any of four sides, output on all four sides
extends Channel


func get_targets() -> Array[Vector2i]:
	return [cell + Vector2i.UP, cell + Vector2i.RIGHT,
		cell + Vector2i.DOWN, cell + Vector2i.LEFT]


func accepts_water(_water_direction: Vector2i) -> bool:
	return true
