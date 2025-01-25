extends Node2D

func _ready() -> void:
	$CanvasLayer/Area2D.count = 2
	$AnimationPlayer.play_backwards("start")
func _physics_process(delta: float) -> void:
	if $bubble.ded:
		$AnimationPlayer.play("start")
		await get_tree().create_timer(1.1).timeout
		get_tree().reload_current_scene()
	elif $bubble.win:
		await get_tree().create_timer(4).timeout
		$bubble.win = false
		$AnimationPlayer.play("start")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://lvl_test_2.tscn")
	if Input.is_action_just_pressed("ui_accept"):
		pass
