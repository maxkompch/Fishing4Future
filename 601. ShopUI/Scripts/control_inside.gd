extends Node
		
func _ready():
	GameData.load_data()
	$FishSell.text = "Sell " + str(GameData.total_fish_caught) + " Fish\nThat You Have"
	$info_fish.text = "Fish Price \nis $" + str(GameData.fish_price) + ",\nYour Fish\nare worth\n$" + str(GameData.fish_price*GameData.total_fish_caught)
	$Fish2.disabled = GameData.fish_bubbles_2
	$Fish3.disabled = not GameData.fish_bubbles_2 or GameData.fish_bubbles_3
	$Plastic2.disabled = GameData.plastic_bubbles_2
	$Plastic3.disabled = not GameData.plastic_bubbles_2 or GameData.plastic_bubbles_3
	if GameData.fish_bubbles_2:
		$Fish2.text = "Bought" 
	if GameData.fish_bubbles_3:
		$Fish3.text = "Bought"
	if GameData.plastic_bubbles_2:
		$Plastic2.text = "Bought"
	if GameData.plastic_bubbles_3:
		$Plastic3.text = "Bought"

func update_coin_display() -> void:
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

	if GameData.total_fish_caught > 0:
		var earnings = GameData.total_fish_caught * GameData.fish_price
		GameData.add_money(earnings)
		GameData.total_reset_func()
		GameData.save_data()
		time_system.log("sold all fish for $" + str(earnings))
		$purchasedaudio.play()
		$FishSell.text = "Sell " + str(GameData.total_fish_caught) + " Fish\nThat You Have"
		$info_fish.text = "Fish Price \nis $" + str(GameData.fish_price) + ",\nYour Fish\nare worth\n$" + str(GameData.fish_price*GameData.total_fish_caught)
	else:
		time_system.log("sell attempt failed")
		$notenoughaudio.play()

func _on_fish_2_pressed() -> void:
	var item_cost = 15
	if GameData.player_money >= item_cost and not GameData.fish_bubbles_2:
		GameData.subtract_money(item_cost)
		GameData.purchase_fishbubble2()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Fish2.disabled = true
		$Fish3.disabled = false
		$Fish2.text = "Bought"
		time_system.log("bought 2 fish bubbles")
	else:
		show_notenough_popup()
		time_system.log("failed 2 fish bubbles")
		
func _on_fish_3_pressed() -> void:
	var item_cost = 25
	if GameData.player_money >= item_cost and GameData.fish_bubbles_2 and not GameData.fish_bubbles_3:
		GameData.subtract_money(item_cost)
		GameData.purchase_fishbubble3()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Fish3.disabled = true
		$Fish3.text = "Bought"
		time_system.log("bought 3 fish bubbles")
	else:
		show_notenough_popup()
		time_system.log("failed 3 fish bubbles")			
		
func _on_plastic_2_pressed() -> void:
	var item_cost = 15
	if GameData.player_money >= item_cost and not GameData.plastic_bubbles_2:
		GameData.subtract_money(item_cost)
		GameData.purchase_plasticbubble2()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Plastic2.disabled = true
		$Plastic3.disabled = false
		$Plastic2.text = "Bought"
		time_system.log("bought 2 plastic bubbles")
	else:
		show_notenough_popup()
		time_system.log("failed 2 plastic bubbles")

func _on_plastic_3_pressed() -> void:
	var item_cost = 25
	if GameData.player_money >= item_cost and GameData.plastic_bubbles_2 and not GameData.plastic_bubbles_3:
		GameData.subtract_money(item_cost)
		GameData.purchase_plasticbubble3()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Plastic3.disabled = true
		$Plastic3.text = "Bought"
		time_system.log("bought 3 plastic bubbles")
	else:
		show_notenough_popup()
		time_system.log("failed 3 plastic bubbles")
