extends Node

const MAX_SPRINKLER_SOUNDS := 3
const DOG_WALKING_SOUNDS: Array[AudioStream] = [
	preload("res://assets/sounds/move1.wav"),
	preload("res://assets/sounds/move2.wav"),
	preload("res://assets/sounds/move3.wav"),
]

var _sprinkler_sfx_players: Array[AudioStreamPlayer2D] = []
var _dog_walk_sfx_player: AudioStreamPlayer

func play(sound: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
	var player := AudioStreamPlayer.new()
	player.stream = sound
	player.volume_db = volume_db
	player.pitch_scale = maxf(pitch_scale, 0.01)
	add_child(player)
	player.finished.connect(player.queue_free)
	player.play()


func play_dog_walking_sound() -> void:
	if _dog_walk_sfx_player == null:
		_dog_walk_sfx_player = AudioStreamPlayer.new()
		_dog_walk_sfx_player.name = "DogWalking"
		add_child(_dog_walk_sfx_player)
	if _dog_walk_sfx_player.playing:
		return
	_dog_walk_sfx_player.stream = DOG_WALKING_SOUNDS.pick_random()
	_dog_walk_sfx_player.play()


func stop_dog_walking_sound() -> void:
	if _dog_walk_sfx_player != null:
		_dog_walk_sfx_player.stop()


func start_sprinkler(sfx_player: AudioStreamPlayer2D) -> void:
	if _sprinkler_sfx_players.has(sfx_player):
		return
	_sprinkler_sfx_players.append(sfx_player)
	_update_sprinkler_sounds()


func stop_sprinkler(player: AudioStreamPlayer2D) -> void:
	_sprinkler_sfx_players.erase(player)
	player.stop()
	_update_sprinkler_sounds()


func _update_sprinkler_sounds() -> void:
	for index in range(_sprinkler_sfx_players.size()):
		var player := _sprinkler_sfx_players[index]
		if index < MAX_SPRINKLER_SOUNDS:
			if not player.playing:
				player.play()
		else:
			player.stop()
