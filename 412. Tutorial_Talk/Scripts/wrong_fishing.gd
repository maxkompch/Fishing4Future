extends Control

var Dialog_text = ["Oh...", 
			"This isn't plastic... it's fish",
			"You can keep it and sell it later.",
			"A mans gotta make money to survive.",
			"But if you take too many, we won't be having any fish anymore",
			"And I'll put you in jail myself for killing our ecosystem! Until then...",
			"Go back and to the next marked spot.",
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
	if tutorial_var.fifth_finished == false and tutorial_var.fourth_finished == true and tutorial_var.fished_once == true and tutorial_var.sixth_finished == false:
		$".".visible = true
		if Input.is_action_just_released("action"):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				$".".visible = false
				tutorial_var.fifth_finished = true
			Text.text = Dialog_text[DialogPlatz]
	else:
		$".".visible = false


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
