extends Control

var Dialog_text = ["...", 
				"Normally... This would be unforgiven and you would get a sentence up to 3 years in prison", 
				"But I heard, that you did it for your starving family.",
				"...", 
			 ]
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $"../RichTextLabel"

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
			$".".visible = false
			$"../RichTextLabel".visible = false
			SceneTransitionLight.transition()
			await SceneTransitionLight.on_transition_finished
			get_tree().change_scene_to_file("res://401. Cut Scene/Scenes/family_scene.tscn")
		Text.text = Dialog_text[DialogPlatz]
	


func _on_timer_timeout() -> void:
	if(wordCount < 10000):
		wordCount += 1
		Text.visible_characters = wordCount
	
