extends Area2D


func _ready() -> void:
	await get_tree().create_timer(2).timeout
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.scaling = body.scale + Vector2(0.25,0.25) if body.scale + Vector2(0.25,0.25) <= Vector2(1.25,1.25) else Vector2(1.25,1.25)
		body.shoot += 1
		create_tween().tween_property(self,"scale",Vector2.ZERO,0.3).set_ease(Tween.EASE_IN)
		await get_tree().create_timer(0.3).timeout
		queue_free()
var x: float

func _physics_process(delta: float) -> void:
	x += delta
	position += Vector2(sin(x),cos(x))/4
