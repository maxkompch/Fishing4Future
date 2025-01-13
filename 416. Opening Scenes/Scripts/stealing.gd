extends Control

var stealing_text = ["Upon entering, you feel your hands sweating slowly",
				"You never stole before",
				"You're having second thoughts",
				"'What if I get caught?'",
				"But thinking about your children and wife, you can't help staring at a can of food.",
				"Will you steal?",
				]
var no_answer = ["Are you sure?"]
var no_answer2 = ["Are you sure sure?"]
var no_answer3 = ["Are you reeeeeeally sure?"]
var no_answer4 = ["Dude... Think about your family man..."]
var Dialog_text
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
var counter = 0
@onready var Text = $RichTextLabel

var no_pressed = false
var rng = RandomNumberGenerator.new()
enum States {DIALOG, ANSWER}

var state: States = States.DIALOG

var pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialog_text =  stealing_text
	Anzahl_an_Dialog_text = Dialog_text.size()
	Text.text = Dialog_text[0]
	$MarginContainer/first.visible = false
	$MarginContainer2/second.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == States.DIALOG:
		if (DialogPlatz > Anzahl_an_Dialog_text-2):
			DialogPlatz = Dialog_text.size() -1				
			state = States.ANSWER
			$MarginContainer/first.visible = true
			$MarginContainer2/second.visible = true
		elif (Input.is_action_just_released("action")):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			Text.text = Dialog_text[DialogPlatz]
	elif state == States.ANSWER:
		if no_pressed:
			state = States.DIALOG
			no_pressed = false


func _on_timer_timeout():
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount


func _on_first_pressed() -> void:
	SceneTransitionLight.transition()
	await SceneTransitionLight.on_transition_finished
	get_tree().change_scene_to_file("res://401. Cut Scene/Scenes/court_scene1.tscn")


	
func _on_second_pressed() -> void:
	no_pressed = true
	counter+=1
	if (counter> 15):
		Dialog_text =  no_answer
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
		$MarginContainer2/second.visible = false
		$MarginContainer2.visible = false
	elif (counter > 10):
		Dialog_text =  no_answer4
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
		no_pressed = false
		var randomX = rng.randf_range(624.0, 1000.0)
		var randomY = rng.randf_range(0.0, 377.0)
		pos.x = randomX
		pos.y = randomY
		$MarginContainer2.set_position(pos)
	elif (counter> 4):
		no_pressed = false
		var randomX = rng.randf_range(624.0, 1000.0)
		var randomY = rng.randf_range(0.0, 377.0)
		pos.x = randomX
		pos.y = randomY
		$MarginContainer2.set_position(pos)
	elif (counter> 3):
		Dialog_text =  no_answer3
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
		pass
	elif (counter> 2):
		Dialog_text =  no_answer3
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
	elif (counter> 1):
		Dialog_text =  no_answer2
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
	else:
		Dialog_text =  no_answer
		Anzahl_an_Dialog_text = Dialog_text.size()
		Text.text = Dialog_text[0]
