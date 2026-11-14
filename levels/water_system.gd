class_name WaterSystem
extends Node

@export var objects_layer: TileMapLayer

var channels: Dictionary[Vector2i, Channel] = {}
var _water_sources: Array[Channel] = []


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
	update_water_flow()


func update_water_flow() -> void:
	var watered_channels: Array[Channel] = _water_sources.duplicate()
	var channels_checked = 0
	while channels_checked < watered_channels.size():
		var current_channel = watered_channels[channels_checked]
		channels_checked += 1
		if not current_channel.can_flow:
			continue
		for target_cell in current_channel.get_targets():
			# Find valid channel object in cell
			var target_channel = channels.get(target_cell)
			if target_channel == null or target_channel in watered_channels:
				continue
			# Check input direction
			if current_channel.can_supply(target_channel):
				watered_channels.append(target_channel)

	# Update watered state in all channels
	for channel in channels.values():
		channel.set_watered(channel in watered_channels)
