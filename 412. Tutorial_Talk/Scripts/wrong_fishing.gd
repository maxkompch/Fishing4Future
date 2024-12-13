extends Control

var Dialog_text = ["Oh...", 
			"This isn't plastic...",
			"You can keep it and sell it later.",
			"A mans gotta make money to survive.",
			"But if you take too many, we won't be having any fish anymore",
			"And I'll put you in jail myself for killing our ecosystem! Until then...",
			"Let's go back",
			 ]
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $RichTextLabel

 #Called when the node enters the scene tree for the first time.
func _ready():
	GameData.load_data()
	if GameData.wrongFishing_shown == false:  # Show dialog only if it hasn't been shown yet
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
		GameData.wrongFishing_shown = true
		GameData.save_data()
	else:
		end_dialog()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tutorial_var.fifth_finished == false and tutorial_var.fished_once == true:
		$".".visible = true
		if Input.is_action_just_released("action"):
			if DialogPlatz >= Anzahl_an_Dialog_text - 1 and wordCount >= Dialog_text[DialogPlatz].length():
				DialogPlatz = 0
				end_dialog()
				GameData.wrongFishing_shown = true
				tutorial_var.fifth_finished = true
				tutorial_var.plastic_fished = true
				$".".visible = false
				GameData.save_data()
				return
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
		Text.text = Dialog_text[DialogPlatz]
	else:
		$".".visible = false


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
		
func end_dialog():
	self.queue_free() # Removes this dialog scene completely
	# Or use this to hide the dialog without removing it:
	# self.visible = false
