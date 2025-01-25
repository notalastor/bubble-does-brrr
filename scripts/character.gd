extends CharacterBody2D
var max_speed: float = 400
const accel: float = 1500
const friction: float = 300
var x: float
var shoot: int = 1
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
func get_input() -> Vector2:
	return Input.get_vector("ui_left","ui_right","ui_up","ui_down")

func movement() -> void:
	x += get_physics_process_delta_time()
	rotation = ((sin(x) * cos(x))) *0.2
	if get_input() == Vector2.ZERO:
		if velocity.length() > (friction * get_physics_process_delta_time()):
			velocity -= velocity.normalized() * (friction*get_physics_process_delta_time())
		else:
			velocity = Vector2.ZERO
	else:
		velocity += get_input() * accel * get_physics_process_delta_time()
		velocity = velocity.limit_length(max_speed) 
	move_and_slide()

var scaling: Vector2 = Vector2.ONE
func shooting():
	if scaling < Vector2(0.75,0.75): scaling = Vector2(0.75,0.75)
	
	scale = lerp(scale,scaling,get_physics_process_delta_time()*10)
	if Input.is_action_just_pressed("ml"):
		if shoot > 0:
			$AudioStreamPlayer2D.play()
			shoot -= 1
			scaling = scale - Vector2(0.25,0.25) if scaling >= Vector2(0.75,0.75) else Vector2(0.75,0.75)
			var bullet = preload("res://scenes/character_body_2d.tscn").instantiate()
			get_parent().add_child(bullet)
			bullet.position = $BackgroundEraser.global_position
			create_tween().tween_property(bullet,"position",$pointer.global_position,1.5).set_ease(Tween.EASE_IN_OUT)
			print(bullet.position)
var max_length: int = 64
func looking():
	$BackgroundEraser.global_position = get_global_mouse_position()
	$pointer.global_position = get_global_mouse_position()
	$BackgroundEraser.position = ($BackgroundEraser.position).limit_length(max_length)
	$pointer.position = ($pointer.position).limit_length(max_length*4)
var ded: bool = false
var win: bool = false
func _physics_process(_delta: float) -> void:
	if ded or win:
		$CPUParticles2D.emitting = true
		ded = false
		win = false
		$AudioStreamPlayer2D2.play()
		max_speed = 0
		create_tween().tween_property(self, "scaling", Vector2(0.75,0.75),0.1)
		create_tween().tween_property($Icon, "modulate",Color.TRANSPARENT,0.18)
		create_tween().tween_property($BackgroundEraser, "modulate",Color.TRANSPARENT,0.18)
		create_tween().tween_property($pointer, "modulate",Color.TRANSPARENT,0.18)
	shooting()
	movement()
	looking()
