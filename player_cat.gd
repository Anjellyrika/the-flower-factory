extends CharacterBody2D

@export var move_speed: float = 100
@export var starting_dir: Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
func _ready():
	_update_animation_parameters(starting_dir)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inspect"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	
func _physics_process(_delta):
	# Set Input Direction
	var input_dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
		
	_update_animation_parameters(input_dir)
			
	# Update Velocity
	velocity = input_dir * move_speed
	
	# Update Player Position
	player_data.player_pos = global_position
	
	# Move and Slide Function
	move_and_slide()
	
	pick_new_state()
	
func _update_animation_parameters(move_input: Vector2):
	# Should only chnage parameters if there is input
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

# Change state
func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
