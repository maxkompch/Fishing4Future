extends Control

var player
var input_vector = Vector2.ZERO

# Add these onready variables to reference your buttons
@onready var btn_up = $TopRow/btn_up
@onready var btn_down = $ButtomRow/btn_down
@onready var btn_left = $MidRow/btn_left
@onready var btn_right = $MidRow/btn_right

func _ready():
	# Find the player node
	player = get_tree().get_first_node_in_group("player")
	if !player:
		push_error("Player node not found! Make sure the Player node is in the 'player' group")
		
	# Connect button signals
	btn_up.button_down.connect(_on_btn_up_pressed)
	btn_up.button_up.connect(_on_btn_up_released)
	
	btn_down.button_down.connect(_on_btn_down_pressed)
	btn_down.button_up.connect(_on_btn_down_released)
	
	btn_left.button_down.connect(_on_btn_left_pressed)
	btn_left.button_up.connect(_on_btn_left_released)
	
	btn_right.button_down.connect(_on_btn_right_pressed)
	btn_right.button_up.connect(_on_btn_right_released)

func _process(_delta):
	if player:
		player.set_movement_input(input_vector)

func _on_btn_up_pressed():
	input_vector.y = -1
	
func _on_btn_up_released():
	input_vector.y = 0 if input_vector.y < 0 else input_vector.y

func _on_btn_down_pressed():
	input_vector.y = 1
	
func _on_btn_down_released():
	input_vector.y = 0 if input_vector.y > 0 else input_vector.y

func _on_btn_left_pressed():
	input_vector.x = -1
	
func _on_btn_left_released():
	input_vector.x = 0 if input_vector.x < 0 else input_vector.x

func _on_btn_right_pressed():
	input_vector.x = 1
	
func _on_btn_right_released():
	input_vector.x = 0 if input_vector.x > 0 else input_vector.x
