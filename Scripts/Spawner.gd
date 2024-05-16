extends Node2D

var pool
var player

var cycles := 1
var shot_delay := 0.1
var offset := Vector2(0.0, 0.0)
var init_delay := 0.0
var bullet_data := { }
var spawn_params := { }

var spawn_func := Callable(self, "linear")


func set_bullet_data(b) -> void:
	if bullet_data.has("color"):
		b.set_color(bullet_data.color)
	if bullet_data.has("velocity"):
		b.velocity = bullet_data.velocity
	if bullet_data.has("lifetime"):
		b.lifetime = bullet_data.lifetime
	b.rotate(PI/2)
	if bullet_data.has("target") && bullet_data.target == true:
		b.look_at(player.position)
	if bullet_data.has("frequency"):
		b.frequency = bullet_data.frequency
	if bullet_data.has("amplitude"):
		b.amplitude = bullet_data.amplitude
	if bullet_data.has("movement"):
		b.set_movement(bullet_data.movement)

func activate() -> void:
	pool = get_tree().get_first_node_in_group("BulletPool")
	player = get_tree().get_first_node_in_group("Player")
	if init_delay > 0:
		await get_tree().create_timer(init_delay).timeout

	var delay = Timer.new()
	delay.wait_time = shot_delay
	self.add_child(delay)
	for c in cycles:
		delay.start()
		spawn_func.call(spawn_params)
		await delay.timeout

### Shaping functions ###
func set_type(type: String) -> void:
	match type:
		"linear":
			spawn_func = Callable(self, "linear")
		"radial":
			spawn_func = Callable(self, "radial")

func linear(params) -> void:
	for j in range(params["amount"]):
		var b = pool.bullet()
		set_bullet_data(b)
		b.position.x += -100 + (j * 100)
	await get_tree().create_timer(shot_delay).timeout

func radial(params) -> void:
	for i in range(params["amount"]):
		var b = pool.bullet()
		set_bullet_data(b)
		b.rotation_degrees += i * (360 / params["amount"])
	await get_tree().create_timer(shot_delay).timeout

# Spawn radial (from deg, to deg, number) REST (velcity, color, lifetime, target)
# Spawn radial (from deg, to deg, number) REST (velcity, color, lifetime)
