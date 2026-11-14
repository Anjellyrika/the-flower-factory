class_name Channel
extends Node2D

signal changed
signal flow_ready

@export var input_direction := Vector2i.LEFT
@export var output_direction := Vector2i.RIGHT
@export_range(0.0, 5.0, 0.1) var flow_delay := 0.2

var cell: Vector2i
var watered := false
var can_flow := false
var _time_left := 0.0


func _process(delta: float) -> void:
	if (not watered) or can_flow:
		return
	# Countdown before outputting water
	_time_left -= delta
	if _time_left <= 0.0:
		can_flow = true
		flow_ready.emit()


func get_targets() -> Array[Vector2i]:
	return [cell + output_direction] # Default target is adjacent tile


func can_supply(target: Channel) -> bool:
	var distance_to_target := target.cell - cell
	var water_direction := distance_to_target.sign()
	return target.accepts_water(water_direction)


func accepts_water(water_direction: Vector2i) -> bool:
	return water_direction == -input_direction


func set_watered(value: bool) -> void:
	if watered == value:
		return
	watered = value
	can_flow = false # Newly watered cells must wait for the flow delay before outputting watr
	_time_left = flow_delay
	modulate = Color(0.6, 0.8, 1.0) if watered else Color.WHITE
