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
var target := false
var bullet_data := { }
var spawn_params := { }
# TODO possibly remove. ATM there are only two functions & radial can do evertying linear can
var spawn_func := Callable(self, "linear")
var friend := false

var can_fire := true
var shot_timer: Timer

func _ready() -> void:
	shot_timer = Timer.new()
	shot_timer.one_shot = true
	shot_timer.autostart = false
	self.add_child(shot_timer)
	shot_timer.timeout.connect(_on_shot_timeout)

	self.set_process(false)

func _process(delta: float) -> void:
	self.rotate(angular_rate * delta)

func reset() -> void:
	cycles = 1
	shot_delay = 0.1
	offset = Vector2(0.0, 0.0)
	random_range = Vector2(0.0, 0.0)
	init_delay = 0.0
	angular_rate = 0.0
	target = false
	bullet_data = { }
	spawn_params = { }
	spawn_func = Callable(self, "linear")
	friend = false
	can_fire = true

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
	if s.has("friend"):
		self.friend = s.friend
	if s.has("type"):
		self.set_type(s.type)
	if s.has("spawn_params"):
		self.spawn_params = s.spawn_params
	if s.has("bullet_data"):
		self.bullet_data = s.bullet_data

	shot_timer.wait_time = shot_delay

func set_bullet_data(b) -> void:
	b.scale = Vector2.ONE * 0.5
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

	self.set_process(true)

func activate_and_auto_fire() -> void:
	activate()

	if init_delay > 0:
		await get_tree().create_timer(init_delay).timeout

	for c in cycles:
		shot_timer.start()
		can_fire = true
		fire()
		await shot_timer.timeout

	finish()

func fire() -> bool:
	if can_fire && cycles > 0:
		cycles -= 1
		spawn_func.call(spawn_params)
		can_fire = false
		shot_timer.start()
		return true
	return false

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
	var b = pool.bullet() if !friend else pool.player_bullet()
	set_bullet_data(b)

func radial(params) -> void:
	var angle = 360
	if params.has("degrees"):
		angle = params["degrees"]
	for i in range(params["amount"]):
		var b = pool.bullet() if !friend else pool.player_bullet()
		b.rotation = rotation
		set_bullet_data(b)

		b.rotation_degrees += (-angle / 2) + i * (angle / (params["amount"]-1))
		if random_range != Vector2.ZERO:
			b.rotation_degrees += globals.bullet_rng.randi_range(random_range.x, random_range.y)

func _on_shot_timeout() -> void:
	can_fire = true
