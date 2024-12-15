extends Control

var Dialog_text = ["Good Morning everyone!", 
				"We have gathered here today, to rule a judgement over a young persons life", 
				"You.",
				"You have stolen food from a local supermarket.", 
			 ]
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $"../RichTextLabel"

# Called when the node enters the scene tree for the first time.
func _ready():
	time_system.log("court scene")
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
			$".".visible = false
			$"../RichTextLabel".visible = false
			SceneTransitionLight.transition()
			await SceneTransitionLight.on_transition_finished
			get_tree().change_scene_to_file("res://401. Cut Scene/Scenes/supermarket_scene.tscn")
		Text.text = Dialog_text[DialogPlatz]
	


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
