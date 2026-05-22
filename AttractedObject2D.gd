extends Node2D
class_name AttractedObject2D

@export var attracted_to_node : Node2D;
@export var radius : float = 100;
@export var speed : float = 10;
@export var curve : Curve;
@export var kill_at_distance_below : float = 10; ## At -1 it won't kill

signal destroyed(node : Node2D, global_pos : Vector2)

func _process(delta: float) -> void:
	var target_pos = attracted_to_node.global_position
	var to_target = target_pos - global_position
	var distance = to_target.length()
	if distance <= 0.0 or distance > radius:
		return
	var t = 1.0 - (distance / radius)
	var speed_multiplier = curve.sample(t) if curve else t * t
	global_position += to_target.normalized() * speed * speed_multiplier * delta
	if kill_at_distance_below != -1:
		if kill_at_distance_below > distance:
			emit_signal("destroyed", self, global_position)
			queue_free()
