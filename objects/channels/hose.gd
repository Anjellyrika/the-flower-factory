## Hoses supply water from a distance and without following an input direction.
## Input on one side, output on the opposite side
## Interact to adjust the distance
extends Channel

@export_range(2, 4, 1) var distance := 2

@onready var pressure_label: Label = $PressureLabel


func _ready() -> void:
	pressure_label.text = str(distance - 1)


func interact() -> void:
	adjust_pressure()


func get_targets() -> Array[Vector2i]:
	return [cell + get_output_direction() * distance]


func can_supply(_target: Channel) -> bool:
	return true


func adjust_pressure() -> void:
	distance = 2 if distance == 4 else distance + 1
	pressure_label.text = str(distance - 1)
	changed.emit()
