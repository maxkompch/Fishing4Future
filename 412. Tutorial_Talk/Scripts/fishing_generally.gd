extends Control

var Dialog_text = ["Try to press the hook button in the perfect moment to fish", 
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
	
	if tutorial_var.fourth_finished == false and tutorial_var.third_finished == true and tutorial_var.fish_spot_entered and tutorial_var.sixth_finished == false:
		$".".visible = true
		if Input.is_action_just_released("action"):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				$".".visible = false
				tutorial_var.fourth_finished = true
			Text.text = Dialog_text[DialogPlatz]
	else:
		$".".visible = false
	pass


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
