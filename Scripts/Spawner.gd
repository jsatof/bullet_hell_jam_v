extends Node2D

@onready var globals = get_node("/root/GlobalState")

var pool
var player

var cycles := 1
var shot_delay := 0.1
var offset := Vector2(0.0, 0.0)
var random_range := Vector2(0.0, 0.0)
var init_delay := 0.0
var angular_rate := 0.0
var target = false
var bullet_data := { }
var spawn_params := { }
# TODO possibly remove. ATM there are only two functions & radial can do evertying linear can
var spawn_func := Callable(self, "linear")

func _ready() -> void:
	self.set_process(false)

func _process(delta: float) -> void:
	self.rotate(angular_rate * delta)

func set_spawner_data(s) -> void:
	self.rotation = 0.0
	if s.has("cycles"):
		self.cycles = s.cycles
	if s.has("shot_delay"):
		self.shot_delay = s.shot_delay
	if s.has("init_delay"):
		self.init_delay = s.init_delay
	if s.has("offset"):
		self.offset = s.offset
	if s.has("rotation"):
		self.rotation_degrees = s.rotation
	if s.has("angular_rate"):
		self.angular_rate = s.angular_rate
	if s.has("random"):
		self.random_range = s.random
	if s.has("target"):
		self.target = s.target
	self.set_type(s.type)
	self.spawn_params = s.spawn_params
	self.bullet_data = s.bullet_data

func set_bullet_data(b) -> void:
	b.position = self.global_position
	b.rotation_degrees = self.rotation_degrees
	b.rotate(PI/2) # Rotate 90 degrees for downward firing
	if bullet_data.has("size"):
		b.scale *= bullet_data.size
	if bullet_data.has("color"):
		b.set_color(bullet_data.color)
	if bullet_data.has("velocity"):
		b.velocity = bullet_data.velocity
	if bullet_data.has("lifetime"):
		b.lifetime = bullet_data.lifetime
	if bullet_data.has("frequency"):
		b.frequency = bullet_data.frequency
	if bullet_data.has("amplitude"):
		b.amplitude = bullet_data.amplitude
	if bullet_data.has("movement"):
		b.set_movement(bullet_data.movement)
	if bullet_data.has("acceleration"):
		b.acceleration = bullet_data.acceleration
	if target:
		b.look_at(player.position)
		# Bullets can target the player with a random offset
		if random_range != Vector2.ZERO:
			b.rotation_degrees += globals.bullet_rng.randi_range(random_range.x, random_range.y)

func activate() -> void:
	pool = get_tree().get_first_node_in_group("pools")
	player = get_tree().get_first_node_in_group("Player")
	if init_delay > 0:
		await get_tree().create_timer(init_delay).timeout
	self.set_process(true)

	var delay = Timer.new()
	delay.wait_time = shot_delay
	self.add_child(delay)
	for c in cycles:
		delay.start()
		spawn_func.call(spawn_params)
		await delay.timeout

	finish()

func finish() -> void:
	self.queue_free()

### Shaping functions ###
func set_type(type: String) -> void:
	match type:
		"linear":
			spawn_func = Callable(self, "linear")
		"radial":
			spawn_func = Callable(self, "radial")

func linear(params) -> void:
	var b = pool.bullet()
	set_bullet_data(b)

	await get_tree().create_timer(shot_delay).timeout

func radial(params) -> void:
	var angle = 360
	if params.has("degrees"):
		angle = params["degrees"]
	for i in range(params["amount"]):
		var b = pool.bullet()
		b.rotation = rotation
		set_bullet_data(b)

		b.rotation_degrees += (-angle / 2) + i * (angle / (params["amount"]-1))
		# b.rotation_degrees -= angle / 2
		if random_range != Vector2.ZERO:
			b.rotation_degrees += globals.bullet_rng.randi_range(random_range.x, random_range.y)

	await get_tree().create_timer(shot_delay).timeout
