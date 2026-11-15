## Add as a child of an object with an interact() method.
extends Area2D

@onready var object_node: Node2D = get_parent() as Node2D

var _base_modulate := Color.WHITE


func _ready() -> void:
	_base_modulate = object_node.modulate
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_interactable"):
		body.add_interactable(object_node)
		object_node.modulate = Color.from_rgba8(255, 110, 210)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("remove_interactable"):
		body.remove_interactable(object_node)
		object_node.modulate = _base_modulate
