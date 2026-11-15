## Add as a child of an object with an interact() method.
extends Area2D

@onready var object_node: Node2D = get_parent() as Node2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_interactable"):
		body.add_interactable(object_node)


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("remove_interactable"):
		body.remove_interactable(object_node)
