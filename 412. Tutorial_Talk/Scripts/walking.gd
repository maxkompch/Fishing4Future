extends Control

var Dialog_text = ["...",
	"You new here?"]

var new_player_dialog = ["Move with W,A,S,D and follow me"]

var skip_dialog = ["Perfect, have lots of fun fishing."]

enum States {DIALOG, ANSWER}

var state: States = States.DIALOG

var answer_pressed = false

var global = false

var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var Text = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Anzahl_an_Dialog_text = Dialog_text.size()
	Text.text = Dialog_text[0]
	$first.visible = false
	$second.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == States.DIALOG:
		if Input.is_action_just_released("action"):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if answer_pressed and (DialogPlatz > Anzahl_an_Dialog_text-1):
				$".".visible = false
				DialogPlatz = 0
				Global.dialog_finished = global
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				$first.visible = true
				$second.visible = true
				state = States.ANSWER
				$SkipE.visible = false
			Text.text = Dialog_text[DialogPlatz]
	elif state == States.ANSWER:
		if answer_pressed:
			state = States.DIALOG
			
	pass


func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount


func _on_first_pressed() -> void:
	answer_pressed = true
	$first.visible = false
	$second.visible = false
	$SkipE.visible = true
	Anzahl_an_Dialog_text = new_player_dialog.size()
	Text.text = new_player_dialog[0]
	global = true

func _on_second_pressed() -> void:
	answer_pressed = true
	$first.visible = false
	$second.visible = false
	$SkipE.visible = true
	$"../Path2D/PathFollow2D/PoliceNpc".visible = false
	Anzahl_an_Dialog_text = skip_dialog.size()
	Text.text = skip_dialog[0]
	tutorial_var.is_tutorial = false
	global = false
	$"../StaticBody2D3/CollisionShape2D".disabled = true
	time_system.is_paused = false
