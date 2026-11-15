class_name WaterSystem
extends Node

const SPLASH_SCENE := preload("res://objects/map_tiles/splash.tscn")

@export var objects_layer: TileMapLayer
@export var ground_layer: TileMapLayer

var channels: Dictionary[Vector2i, Channel] = {}
var _water_sources: Array[Channel] = []
var _splashes: Dictionary[Vector2i, Node2D] = {}
var _splash_parent: Node2D


func _ready() -> void:
	objects_layer.update_internals()
	for object in objects_layer.get_children():
		if object is Channel: # Record channel locations
			object.cell = objects_layer.local_to_map(objects_layer.to_local(object.global_position))
			channels[object.cell] = object
			object.changed.connect(update_water_flow)
			object.flow_ready.connect(update_water_flow)
			if object is WaterSource:
				_water_sources.append(object)
				object.set_watered(true)
	_splash_parent = Node2D.new()
	_splash_parent.name = "Splashes"
	objects_layer.add_child(_splash_parent)
	update_water_flow()


func update_water_flow() -> void:
	var watered_channels: Array[Channel] = _water_sources.duplicate()
	var wet_cells: Dictionary[Vector2i, bool] = {}
	var channels_checked = 0
	while channels_checked < watered_channels.size():
		var current_channel = watered_channels[channels_checked]
		channels_checked += 1
		if not current_channel.can_flow:
			continue
		for target_cell in current_channel.get_targets():
			# Find valid channel object in cell
			var target_channel = channels.get(target_cell)
			if target_channel == null:
				if _is_empty_ground(target_cell):
					wet_cells[target_cell] = true
				continue
			if target_channel in watered_channels:
				continue
			# Check input direction
			if current_channel.can_supply(target_channel):
				watered_channels.append(target_channel)

	# Update watered state in all channels
	for channel in channels.values():
		channel.set_watered(channel in watered_channels)
	_update_splashes(wet_cells)


func _is_empty_ground(cell: Vector2i) -> bool:
	if ground_layer == null:
		push_warning("Invalid ground layer.")
		return false
	var world_position := objects_layer.to_global(objects_layer.map_to_local(cell))
	var ground_cell := ground_layer.local_to_map(ground_layer.to_local(world_position))
	if ground_layer.get_cell_source_id(ground_cell) == -1: # No painted tile
		return false
	for object in objects_layer.get_children():
		if object == _splash_parent:
			continue
		var object_cell := objects_layer.local_to_map(objects_layer.to_local(object.global_position))
		if object_cell == cell:
			return false
	return true


func _update_splashes(wet_cells: Dictionary[Vector2i, bool]) -> void:
	for cell in _splashes.keys():
		if not wet_cells.has(cell):
			_splashes[cell].queue_free()
			_splashes.erase(cell)
	for cell in wet_cells:
		if _splashes.has(cell):
			continue
		var splash := SPLASH_SCENE.instantiate() as Node2D
		_splash_parent.add_child(splash)
		splash.position = objects_layer.map_to_local(cell)
		_splashes[cell] = splash
