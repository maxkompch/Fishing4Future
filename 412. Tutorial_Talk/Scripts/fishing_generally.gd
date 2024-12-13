extends Control
 
var Dialog_text = ["Press the button to fish",
			 ]
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $RichTextLabel
 
# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.load_data()
	if not GameData.fishingGenerally_shown:  # Show dialog only if it hasn't been shown yet
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
		GameData.fishingGenerally_shown = true
		GameData.save_data()
	else:
		end_dialog()
 
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$".".visible = false
	if tutorial_var.third_finished == true and tutorial_var.fourth_finished == false:
		$".".visible = true
		if Input.is_action_just_released("action"):
			if DialogPlatz >= Anzahl_an_Dialog_text - 1 and wordCount >= Dialog_text[DialogPlatz].length():
				tutorial_var.fourth_finished = true
				$".".visible = false
				end_dialog()
				GameData.fishingGenerally_shown = true
				GameData.save_data()
				DialogPlatz = 0
				return
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				
			Text.text = Dialog_text[DialogPlatz]
 
 
func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount

func end_dialog():
	self.queue_free()
