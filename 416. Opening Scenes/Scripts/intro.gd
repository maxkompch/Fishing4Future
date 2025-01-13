extends Control

var Dialog_text = ["You walk around aimlessly.",
			"It has already been a few days.", 
			"You're at your wits end.",  
			"Your children are",
			"confused", 
			 "scared", 
			"and hungry", 
			"So hungry...", 
			 "You arrive at a convenience store",
			"A scary thought came across your mind",
			"'What if I steal?'",]
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Anzahl_an_Dialog_text = Dialog_text.size()
	Text.text = Dialog_text[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("action"):
		wordCount = 0
		Text.visible_characters = wordCount
		DialogPlatz += 1
		if (DialogPlatz > Anzahl_an_Dialog_text-1):
			DialogPlatz = 0
			SceneTransitionLight.transition()
			await SceneTransitionLight.on_transition_finished
			get_tree().change_scene_to_file("res://416. Opening Scenes/Scenes/stealing.tscn")
		Text.text = Dialog_text[DialogPlatz]


func _on_timer_timeout():
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
