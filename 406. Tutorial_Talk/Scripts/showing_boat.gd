extends Control

var Dialog_text = ["This is your boat. Press E to enter", 
			"This is your boat. Press E to enter", 
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
	if Global.next_dialog == false:
		$".".visible = false
	elif Global.dialog_finished == false:
		$".".visible = true
		if Input.is_action_just_released("action"):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				Global.dialog_finished = true
				$".".visible = false
			Text.text = Dialog_text[DialogPlatz]
	pass


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
