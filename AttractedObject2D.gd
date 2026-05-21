extends Node2D
class_name AttractedObject2D

@export var attracted_to_node : Node2D;
@export var radius : float = 100;
@export var speed : float = 10;
@export var curve : Curve;

func _process(delta: float) -> void:
	var target_pos = attracted_to_node.global_position
	var to_target = target_pos - global_position
	var distance = to_target.length()
	if distance <= 0.0 or distance > radius:
		return
	var t = 1.0 - (distance / radius)
	var speed_multiplier = curve.sample(t) if curve else t
	global_position += to_target.normalized() * speed * speed_multiplier * delta
