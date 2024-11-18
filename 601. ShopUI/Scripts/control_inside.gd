extends Node
var player_coins = 1000

var rod1_purchased = false
var rod2_purchased = false
var rod3_purchased = false
var net1_purchased = false
var net2_purchased = false
var net3_purchased = false
		
func _ready():
	$Label.text = "$1000"
	$Label.visible = true
	$Rod2.disabled = true
	$Rod3.disabled = true
	$Net2.disabled = true
	$Net3.disabled = true

func update_coin_display() -> void:
	$Label.text = "$" + str(player_coins)
	$ColorRect.visible = false
	$ColorRect2.visible = false

func show_purchase_popup() -> void:
	$ColorRect.visible = true
	$purchased.visible = true
	$purchasedaudio.play()
	await get_tree().create_timer(0.50).timeout 
	$ColorRect.visible = false
	$purchased.visible = false
	
func show_notenough_popup() -> void:
	$ColorRect2.visible = true
	$notenough.visible = true
	$notenoughaudio.play()
	await get_tree().create_timer(0.50).timeout 
	$ColorRect2.visible = false
	$notenough.visible = false
	
func _on_rod_1_pressed() -> void:
	var item_cost = 100
	
	if player_coins >= item_cost and not rod1_purchased:
		player_coins -= item_cost
		rod1_purchased = true
		update_coin_display()
		show_purchase_popup()
		$Rod1.disabled = true
		$Rod2.disabled = false
		$Rod1.text = "Bought"
		print("timestamp: Bought Rod Lv. 1 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	else:
		show_notenough_popup()
		print("timestamp: Unsuccessful upgrade of Rod Lv. 1 for $" + str(item_cost) + ", current money = $" + str(player_coins))

func _on_rod_2_pressed() -> void:
	var item_cost = 200 
	
	if player_coins >= item_cost and rod1_purchased and not rod2_purchased:
		player_coins -= item_cost
		rod2_purchased = true
		update_coin_display()
		show_purchase_popup()
		$Rod2.disabled = true
		$Rod3.disabled = false
		$Rod2.text = "Bought"
		print("timestamp: Bought Rod Lv. 2 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	else:
		show_notenough_popup()
		print("timestamp: Unsuccessful upgrade of Rod Lv. 2 for $" + str(item_cost) + ", current money = $" + str(player_coins))
		
func _on_rod_3_pressed() -> void:
	var item_cost = 300
	
	if player_coins >= item_cost and rod1_purchased and rod2_purchased and not rod3_purchased:
		player_coins -= item_cost
		rod3_purchased = true
		update_coin_display()
		show_purchase_popup()
		$Rod3.disabled = true
		$Rod3.text = "Bought"
		print("timestamp: Bought Rod Lv. 3 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	else:
		show_notenough_popup()
		print("timestamp: Unsuccessful upgrade of Rod Lv. 3 for $" + str(item_cost) + ", current money = $" + str(player_coins))
		


func _on_net_1_pressed() -> void:
	var item_cost = 100
	
	if player_coins >= item_cost and not net1_purchased:
		player_coins -= item_cost
		net1_purchased = true
		update_coin_display()
		show_purchase_popup()
		$Net1.disabled = true
		$Net2.disabled = false
		$Net1.text = "Bought"
		print("timestamp: Bought Net Lv. 1 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	else:
		show_notenough_popup()
		print("timestamp: Unsuccessful upgrade of Net Lv. 1 for $" + str(item_cost) + ", current money = $" + str(player_coins))
		
func _on_net_2_pressed() -> void:
	var item_cost = 200
	
	if player_coins >= item_cost and net1_purchased and not net2_purchased:
		player_coins -= item_cost
		net2_purchased = true
		update_coin_display()
		show_purchase_popup()
		$Net2.disabled = true
		$Net3.disabled = false
		$Net2.text = "Bought"
		print("timestamp: Bought Net Lv. 2 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	else:
		show_notenough_popup()
		print("timestamp: Unsuccessful upgrade of Net Lv. 2 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	
func _on_net_3_pressed() -> void:
	var item_cost = 300
	
	if player_coins >= item_cost and net1_purchased and net2_purchased and not net3_purchased:
		player_coins -= item_cost
		net3_purchased = true
		update_coin_display()
		show_purchase_popup()
		$Net3.disabled = true
		$Net3.text = "Bought"
		print("timestamp: Bought Net Lv. 3 for $" + str(item_cost) + ", current money = $" + str(player_coins))
	else:
		show_notenough_popup()
		print("timestamp: Unsuccessful upgrade of Net Lv. 3 for $" + str(item_cost) + ", current money = $" + str(player_coins))
