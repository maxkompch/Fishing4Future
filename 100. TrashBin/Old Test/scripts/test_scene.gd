# Called when the node en# test_scene.gd
extends Node2D

func _ready():
	var water_scene = preload("res://scenes/water_scene.tscn").instantiate()
	add_child(water_scene)
