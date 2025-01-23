# GUI.gd
extends CanvasLayer

@onready var health_bar = $MarginContainer/Stats/HealthBar
@onready var fish_label = $MarginContainer/Stats/FishCount
@onready var plastics_label = $MarginContainer/Stats/PlasticsCount
@onready var player: CharacterBody2D

func _ready():
	# Wait a frame to ensure the player is ready
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	if player:
		# Connect signals from player
		player.health_changed.connect(_on_player_health_changed)
		player.catch_successful.connect(_on_catch_successful)
		
		# Initialize values
		health_bar.max_value = player.health
		health_bar.value = player.health
		_update_cargo_display()

func _on_player_health_changed(new_health: float):
	health_bar.value = new_health

func _on_catch_successful(item_type: String):
	_update_cargo_display()

func _update_cargo_display():
	if player:
		fish_label.text = "Fish: %d/%d" % [player.current_fish, player.fish_capacity]
		plastics_label.text = "Plastics: %d/%d" % [player.current_plastics, player.plastics_capacity]
