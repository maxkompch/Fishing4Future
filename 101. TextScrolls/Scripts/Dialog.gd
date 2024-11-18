extends Control

var Dialog_text = ["First", 
			"THis is some text shown to the player",
			"It scrolls around",
			"the speed can be set with ther Timer"
			 ]
var Annzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Annzahl_an_Dialog_text = Dialog_text.size()
	Text.text = Dialog_text[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_text_button_up():
	wordCount = 0
	Text.visible_characters = wordCount
	DialogPlatz += 1
	if (DialogPlatz > Annzahl_an_Dialog_text-1):
		DialogPlatz = 0
	Text.text = Dialog_text[DialogPlatz]
	pass # Replace with function body.


func _on_timer_timeout():
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
