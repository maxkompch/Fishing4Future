extends Node
		
func _ready():
	GameData.load_data()
	$FishSell.text = "Sell " + str(GameData.total_fish_caught) + " Fish That You Have"
	$Label.text = "$" + str(GameData.player_money)
	$Label.visible = true
	$Rod1.disabled = GameData.rod1_purchased
	$Rod2.disabled = not GameData.rod1_purchased or GameData.rod2_purchased
	$Rod3.disabled = not GameData.rod2_purchased or GameData.rod3_purchased
	$Net1.disabled = GameData.net1_purchased
	$Net2.disabled = not GameData.net1_purchased or GameData.net2_purchased
	$Net3.disabled = not GameData.net2_purchased or GameData.net3_purchased
	if GameData.rod1_purchased:
		$Rod1.text = "Bought" 
	if GameData.rod2_purchased:
		$Rod2.text = "Bought"
	if GameData.rod3_purchased:
		$Rod3.text = "Bought"
	if GameData.net1_purchased:
		$Net1.text = "Bought"
	if GameData.net2_purchased:
		$Net2.text = "Bought"
	if GameData.net3_purchased:
		$Net3.text = "Bought"

func update_coin_display() -> void:
	$Label.text = "$" + str(GameData.player_money)
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

func _on_fish_sell_pressed() -> void:
	var current_time = time_system.get_time()
	if GameData.total_fish_caught > 0:
		var earnings = GameData.total_fish_caught * 10  # Example: Each fish is worth 10 coins
		GameData.add_money(earnings)
		update_coin_display()
		print(current_time + " || Sold " + str(GameData.total_fish_caught) + " fish for $" + str(earnings) + ", current money = $" + str(GameData.player_money))
		GameData.total_reset_func()
		GameData.save_data()
		$FishSell.text = "Sell " + str(GameData.total_fish_caught) + " Fish That You Have"
	else:
		print(current_time + " || No fish to sell! current money = $" + str(GameData.player_money))

func _on_rod_1_pressed() -> void:
	var item_cost = 100
	var current_time = time_system.get_time()
	if GameData.player_money >= item_cost and not GameData.rod1_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_rod1()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Rod1.disabled = true
		$Rod2.disabled = false
		$Rod1.text = "Bought"
		print(current_time + " || Bought Rod Lv. 1 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	else:
		show_notenough_popup()
		print(current_time + " || Unsuccessful upgrade of Rod Lv. 1 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))

func _on_rod_2_pressed() -> void:
	var item_cost = 200 
	var current_time = time_system.get_time()
	if GameData.player_money >= item_cost and GameData.rod1_purchased and not GameData.rod2_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_rod2()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Rod2.disabled = true
		$Rod3.disabled = false
		$Rod2.text = "Bought"
		print(current_time + " || Bought Rod Lv. 2 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	else:
		show_notenough_popup()
		print(current_time + " || Unsuccessful upgrade of Rod Lv. 2 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
		
func _on_rod_3_pressed() -> void:
	var item_cost = 300
	var current_time = time_system.get_time()
	if GameData.player_money >= item_cost and GameData.rod1_purchased and GameData.rod2_purchased and not GameData.rod3_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_rod3()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Rod3.disabled = true
		$Rod3.text = "Bought"
		print(current_time + " || Bought Rod Lv. 3 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	else:
		show_notenough_popup()
		print(current_time + " || Unsuccessful upgrade of Rod Lv. 3 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
		


func _on_net_1_pressed() -> void:
	var item_cost = 100
	var current_time = time_system.get_time()
	if GameData.player_money >= item_cost and not GameData.net1_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_net1()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Net1.disabled = true
		$Net2.disabled = false
		$Net1.text = "Bought"
		print(current_time + " || Bought Net Lv. 1 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	else:
		show_notenough_popup()
		print(current_time + " || Unsuccessful upgrade of Net Lv. 1 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
		
func _on_net_2_pressed() -> void:
	var item_cost = 200
	var current_time = time_system.get_time()
	if GameData.player_money >= item_cost and GameData.net1_purchased and not GameData.net2_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_net2()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Net2.disabled = true
		$Net3.disabled = false
		$Net2.text = "Bought"
		print(current_time + " || Bought Net Lv. 2 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	else:
		show_notenough_popup()
		print(current_time + " || Unsuccessful upgrade of Net Lv. 2 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	
func _on_net_3_pressed() -> void:
	var item_cost = 300
	var current_time = time_system.get_time()
	if GameData.player_money >= item_cost and GameData.net1_purchased and GameData.net2_purchased and not GameData.net3_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_net3()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Net3.disabled = true
		$Net3.text = "Bought"
		print(current_time + " || Bought Net Lv. 3 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
	else:
		show_notenough_popup()
		print(current_time + " || Unsuccessful upgrade of Net Lv. 3 for $" + str(item_cost) + ", current money = $" + str(GameData.player_money))
