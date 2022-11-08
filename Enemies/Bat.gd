extends KinematicBody2D

export var DeadBat = preload("res://World/DeadBat.tscn")

var knockback = Vector2.ZERO

onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_HurtBox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * 120


func _on_Stats_no_health():
	var deadbat = DeadBat.instance()
	get_parent().add_child(deadbat)
	deadbat.global_position = global_position
	queue_free()
