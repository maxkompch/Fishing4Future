extends Node
		
func _ready():
	GameData.load_data()
	$FishSell.text = "Sell " + str(GameData.total_fish_caught) + " Fish That You Have"
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
		$FishSell.text = "Sell " + str(GameData.total_fish_caught) + " Fish That You Have"
	else:
		time_system.log("sell attempt failed")
		$notenoughaudio.play()

func _on_rod_1_pressed() -> void:
	var item_cost = 100
	if GameData.player_money >= item_cost and not GameData.rod1_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_rod1()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Rod1.disabled = true
		$Rod2.disabled = false
		$Rod1.text = "Bought"
		time_system.log("bought rod lv 1")
	else:
		show_notenough_popup()
		time_system.log("failed rod lv 1")		

func _on_rod_2_pressed() -> void:
	var item_cost = 200 
	if GameData.player_money >= item_cost and GameData.rod1_purchased and not GameData.rod2_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_rod2()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Rod2.disabled = true
		$Rod3.disabled = false
		$Rod2.text = "Bought"
		time_system.log("bought rod lv 2")
	else:
		show_notenough_popup()
		time_system.log("failed rod lv 2")		
		
func _on_rod_3_pressed() -> void:
	var item_cost = 300
	if GameData.player_money >= item_cost and GameData.rod1_purchased and GameData.rod2_purchased and not GameData.rod3_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_rod3()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Rod3.disabled = true
		$Rod3.text = "Bought"
		time_system.log("bought rod lv 3")
	else:
		show_notenough_popup()
		time_system.log("failed rod lv 3")		

func _on_net_1_pressed() -> void:
	var item_cost = 100
	if GameData.player_money >= item_cost and not GameData.net1_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_net1()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Net1.disabled = true
		$Net2.disabled = false
		$Net1.text = "Bought"
		time_system.log("bought net lv 1")
	else:
		show_notenough_popup()
		time_system.log("failed net lv 1")
		
func _on_net_2_pressed() -> void:
	var item_cost = 200
	if GameData.player_money >= item_cost and GameData.net1_purchased and not GameData.net2_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_net2()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Net2.disabled = true
		$Net3.disabled = false
		$Net2.text = "Bought"
		time_system.log("bought net lv 2")
	else:
		show_notenough_popup()
		time_system.log("failed net lv 2")
			
func _on_net_3_pressed() -> void:
	var item_cost = 300
	if GameData.player_money >= item_cost and GameData.net1_purchased and GameData.net2_purchased and not GameData.net3_purchased:
		GameData.subtract_money(item_cost)
		GameData.purchase_net3()
		GameData.save_data()
		update_coin_display()
		show_purchase_popup()
		$Net3.disabled = true
		$Net3.text = "Bought"
		time_system.log("bought net lv 3")
	else:
		show_notenough_popup()
		time_system.log("failed net lv 3")
