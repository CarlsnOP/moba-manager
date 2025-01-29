extends CanvasLayer

#Camera shake credits to The Shaggy Dev
#https://www.youtube.com/watch?v=RVtcnkuNUIk
enum CAMERA_SHAKE_TYPE { RANDOM, NOISE, SWAY }

# How quickly to move through the noise
var NOISE_SHAKE_SPEED: float = 30.0
var NOISE_SWAY_SPEED: float = 1.0
# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
var NOISE_SHAKE_STRENGTH: float = 60.0
var NOISE_SWAY_STRENGTH: float = 10.0
# The starting range of possible offsets using random values
var RANDOM_SHAKE_STRENGTH: float = 20.0
# Multiplier for lerping the shake strength to zero
var SHAKE_DECAY_RATE: float = 8.0

@onready var noise = FastNoiseLite.new()
# Used to keep track of where we are in the noise
# so that we can smoothly move through it
var noise_i := 0.0
@onready var rand = RandomNumberGenerator.new()
var shake_type := CAMERA_SHAKE_TYPE.RANDOM
var shake_strength: float = 0.0

func _ready():
	rand.randomize()
	
	# Randomize the generated noise
	noise.seed = rand.randi()
	# Period affects how quickly the noise changes values
	noise.frequency = 0.5
	
func _process(delta: float) -> void:
	# Fade out the intensity over time
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	
	var shake_offset: Vector2
	
	match shake_type:
		CAMERA_SHAKE_TYPE.RANDOM:
			shake_offset = get_random_offset()
		CAMERA_SHAKE_TYPE.NOISE:
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
		CAMERA_SHAKE_TYPE.SWAY:
			shake_offset = get_noise_offset(delta, NOISE_SWAY_SPEED, NOISE_SWAY_STRENGTH)
	
	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	offset = shake_offset

func apply_random_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH
	shake_type = CAMERA_SHAKE_TYPE.RANDOM
	
func apply_noise_shake() -> void:
	shake_strength = NOISE_SHAKE_STRENGTH
	shake_type = CAMERA_SHAKE_TYPE.NOISE
	
func apply_noise_sway() -> void:
	shake_type = CAMERA_SHAKE_TYPE.SWAY

func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
