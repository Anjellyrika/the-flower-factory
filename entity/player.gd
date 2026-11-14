extends CharacterBody2D

@export var move_speed: float = 200.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * move_speed
	move_and_slide()
	if input_dir.x != 0.0:
		sprite.flip_h = input_dir.x < 0.0
	sprite.play("walk" if input_dir != Vector2.ZERO else "idle")
