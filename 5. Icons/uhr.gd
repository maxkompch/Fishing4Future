extends Sprite2D

@onready var Uhr = $UhrUrsprung
@onready var TrashCan = $"../TrashcanIconsEp" #$"../CaughtfishIconsEp"   #$"../TrashcanIconsEp" #$"../CaughtfishIconsEp"  
@onready var progressbar = $"../ProgressBar"
@onready var mylabel = $"../Label"

var progress = 0
var framposition = 0
var offseteimer = 256

func _ready():
	TrashCan.position.y = 80

func _process(delta):
	pass#	Uhr.rotate(delta)


func _on_timer_timeout():
	#//framposition += 1
	#//if(framposition > 3):
	#	framposition = 0
	#TrashCan.frame = framposition
	
	progress += 1
	if(progress > progressbar.max_value):
		progress = 0
	progressbar.value = progress
	
	TrashCan.position.x = (256 + (progressbar.ratio * 500))
	
	if(progress / progressbar.max_value > 0.75):
		TrashCan.frame = 3
		mylabel.text = "Frame 3 is showing"
	elif(progress / progressbar.max_value >= 0.50):
		TrashCan.frame = 2
		mylabel.text = "Frame 2 is" + str(565) + " showing"
	elif(progress / progressbar.max_value > 0.25):
		TrashCan.frame = 1
		mylabel.text = "Frame 1 is showing"
	else:
		TrashCan.frame = 0
		mylabel.text = "Frame 0 is showing"
	
	pass # Replace with function body.


func Uhrtimer():
	Uhr.rotate((PI*0.01))
	pass # Replace with function body.
