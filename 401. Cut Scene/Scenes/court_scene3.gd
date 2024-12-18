extends Control

var Dialog_text = [				"...", 
				"I have decided, that you will not be punished with 3 years in prison...", 
				"BUT", 
				"because we have a high pollution problem, you will have to fish plastic out of the ocean for 1 Week.",
				"Of course, if you can't reach your daily goals, prison will be the only choice for you.",  
				"So please do your work diligently", 
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
			$"../Timer2".start()
			
		Text.text = Dialog_text[DialogPlatz]
	


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount


func _on_timer_2_timeout() -> void:
	time_system.is_paused = false
	SceneTransition.transition()
	await SceneTransition.on_transition_finished
	get_tree().change_scene_to_file("res://413. Tutorial/Scenes/start_area_tutorial.tscn")
