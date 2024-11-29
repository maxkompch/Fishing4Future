extends Control

var Dialog_text = ["So, we wanna go to your first fishing spot... exciting right?",
				"To enter the fishing spot, you just have to drive into it.",
				"And too make sure you ain't missing it, I marked it." ,
				"If you miss that you can start thinking about jail",
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
	$".".visible = false
	if tutorial_var.third_finished == false and tutorial_var.second_finished == true:
		$".".visible = true
		if Input.is_action_just_released("action"):
			wordCount = 0
			Text.visible_characters = wordCount
			DialogPlatz += 1
			if (DialogPlatz > Anzahl_an_Dialog_text-1):
				DialogPlatz = 0
				tutorial_var.third_finished = true
				$".".visible = false
			Text.text = Dialog_text[DialogPlatz]



func _on_timer_timeout() -> void:
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
