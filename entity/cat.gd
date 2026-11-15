class_name Cat
extends Node2D

@export_range(0.1, 10.0, 0.1) var animation_duration: float = 2.0


func play_bonus(objects_layer: TileMapLayer) -> void:
	global_position = objects_layer.to_global(objects_layer.map_to_local(Vector2i(7, 0)))
	var target_position := objects_layer.to_global(objects_layer.map_to_local(Vector2i(7, 2)))
	var tween := create_tween()
	tween.tween_property(self, "global_position", target_position, animation_duration)
	await tween.finished
