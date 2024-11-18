extends Control

var Dialog_text = ["You new here?", 
			"Move with W,A,S,D.",
			"Figure out the rest.",
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
	if Input.is_action_just_released("action"):
		wordCount = 0
		Text.visible_characters = wordCount
		DialogPlatz += 1
		if (DialogPlatz > Anzahl_an_Dialog_text-1):
			DialogPlatz = 0
		Text.text = Dialog_text[DialogPlatz]
	pass


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
