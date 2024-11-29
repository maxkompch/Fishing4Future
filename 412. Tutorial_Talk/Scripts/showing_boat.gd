extends Control

var Dialog_text = ["", 
			"This is your boat. Just walk into it to sail the ocean", 
			"You start and end your day here",
			"Because this is your first time, I'll come with ya",
			 ]
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Anzahl_an_Dialog_text = Dialog_text.size()
	Text.text = Dialog_text[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tutorial_var.first_finished == false:
		$".".visible = false
	elif tutorial_var.next_dialog == true:
		$".".visible = true
		if Input.is_action_just_released("action"):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				tutorial_var.second_finished = true
				$".".visible = false
				tutorial_var.next_dialog = false
				$"../BarrierBoat/CollisionShape2D".disabled = true
			Text.text = Dialog_text[DialogPlatz]
	else:
		$".".visible = false


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
