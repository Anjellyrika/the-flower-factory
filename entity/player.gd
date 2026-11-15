extends CharacterBody2D

const UP = preload("res://assets/art/diwa-up.png")
const DOWN = preload("res://assets/art/diwa-down.png")
const LEFT = preload("res://assets/art/diwa-left.png")
const RIGHT = preload("res://assets/art/diwa-right.png")

@export var move_speed: float = 200.0

@onready var sprite: Sprite2D = $Sprite2D

var _nearby_interactables: Array[Node2D] = []


func _exit_tree() -> void:
	SfxPlayer.stop_dog_walking_sound()


func add_interactable(target: Node2D) -> void:
	if not target in _nearby_interactables:
		_nearby_interactables.append(target)


func remove_interactable(target: Node2D) -> void:
	_nearby_interactables.erase(target)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_interact()
		get_viewport().set_input_as_handled()


func _interact() -> void:
	var nearest: Node2D = null
	var nearest_distance := INF
	for candidate in _nearby_interactables:
		if not is_instance_valid(candidate) or candidate.is_queued_for_deletion():
			continue
		var distance := global_position.distance_squared_to(candidate.global_position)
		if distance <= nearest_distance:
			nearest = candidate
			nearest_distance = distance
	if nearest != null:
		nearest.call("interact")


func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_dir * move_speed
	move_and_slide()
	if input_dir.x != 0.0:
		sprite.texture = LEFT if input_dir.x < 0.0 else RIGHT
	elif input_dir.y != 0.0:
		sprite.texture = UP if input_dir.y < 0.0 else DOWN
	if input_dir != Vector2.ZERO:
		SfxPlayer.play_dog_walking_sound()
	else:
		SfxPlayer.stop_dog_walking_sound()
