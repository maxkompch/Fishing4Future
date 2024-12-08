class_name TimeSystem extends Node

@export var date_time: DateTime
@export var ticks_index: int = 1
@export var ticks_per_Sec_options: Array[int] = [120, 240, 480, 960, 1920, 24000]

const AUDIO_FILES: Array[String] = [
	"res://602. Global Variables/Scripts/960dec.wav",
	"res://602. Global Variables/Scripts/480dec.wav",
	"res://602. Global Variables/Scripts/240dec.wav",
	"res://602. Global Variables/Scripts/120dec.wav",
	"res://602. Global Variables/Scripts/240inc.wav",
	"res://602. Global Variables/Scripts/480inc.wav",
	"res://602. Global Variables/Scripts/960inc.wav",
	"res://602. Global Variables/Scripts/1920inc.wav",
	"res://602. Global Variables/Scripts/paused.wav",
]

# AudioStreamPlayer instance
var audio_player: AudioStreamPlayer
var is_paused:bool = false
var previous_scene = null
var current_day: int = -1


func _ready():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	date_time = DateTime.new()  # Initialize DateTime here
	# current_day = date_time.days

func _process(delta: float) -> void:
	handle_input()
	if is_paused:
		return
	date_time.increase_by_sec(delta * ticks_per_Sec_options[ticks_index])
	 # if date_time.days != current_day:
		#current_day = date_time.days  # Update the current day
		#GameData.subtract_money(30)
		#GameData.save_data()
		#time_system.log("no")
		
func print_time() -> void:
	if date_time:
		print(date_time.formatted_time)
	
func get_time() -> String:
	if date_time:
		return date_time.formatted_time
	return "Monday 00:00:00"
	
# Custom logging function
func log(message: String) -> void:
	var time_msg = Time.get_datetime_string_from_system() + " || " + get_time() + " || "
	#var resource_msg = "money = $" + str(GameData.player_money) + " || " + "f_pop = " + str(GameData.fish_population) + " || " + "f_caught = " + str(GameData.total_fish_caught) + " || " + "p_pop = " + str(GameData.plastic_population) + " || " + "p_caught = " + str(GameData.total_plastic_caught) + " || "

	var resource_msg = "money = $" + str(GameData.player_money) + ", f_pop = " + str(GameData.fish_population) + ", f_caught = " + str(GameData.total_fish_caught) + ", p_pop = " + str(GameData.plastic_population) + ", p_caught = " + str(GameData.total_plastic_caught) + " || "
	var combined_log = time_msg + resource_msg + message
	var file = FileAccess.open("res://log.txt", FileAccess.READ_WRITE)
	if file:
		file.seek_end()
		file.store_line(combined_log)
		file.close()
	else:
		file = FileAccess.open("res://log.txt", FileAccess.WRITE)
		if file:
			file.store_line(combined_log)
			file.close()
		else:
			print("Failed to create log file!")


func play_audio(file_index: int) -> void:
	var audio_stream = load(AUDIO_FILES[file_index])
	if audio_stream:
		audio_player.stream = audio_stream
		audio_player.play()
	else:
		print("Audio file not found at path:", AUDIO_FILES[file_index])
	
func handle_input() -> void:
	if Input.is_action_just_pressed("dec_speed"):
		ticks_index -= 1
		if ticks_index == 0:
			play_audio(3)
		elif ticks_index == 1:
			play_audio(2)
		elif ticks_index == 2:
			play_audio(1)
		elif ticks_index == 3:
			play_audio(0)
			
	if Input.is_action_just_pressed("inc_speed"):
		ticks_index += 1
		if ticks_index == 1:
			play_audio(4)
		elif ticks_index == 2:
			play_audio(5)
		elif ticks_index == 3:
			play_audio(6)
		elif ticks_index == 4:
			play_audio(7)
	if Input.is_action_just_pressed("pause_time"):
		if not is_paused:
			is_paused = true
			play_audio(8)
			print("Game Paused")  # Debugging message # Play audio only when the game is paused
		else:
			is_paused = false
			print("Game UnPaused")  # Debugging message
		
	ticks_index = clamp(ticks_index, 0, ticks_per_Sec_options.size() - 1)
