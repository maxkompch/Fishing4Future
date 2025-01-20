extends Node2D


func _ready() -> void:
	if GameData.fish_population > 0:
		$FishingArea.visible = true  
		$FishingArea.get_node("CollisionShape2D").disabled = false  
	else:
		$FishingArea.visible = false 
		$FishingArea.get_node("CollisionShape2D").disabled = true  
		
	if GameData.fish_population > 10:
		$FishingArea2.visible = true  # Make FishingArea2 visible
		$FishingArea2.get_node("CollisionShape2D").disabled = false  
	else:
		$FishingArea2.visible = false  
		$FishingArea2.get_node("CollisionShape2D").disabled = true 
		
	if GameData.fish_population > 20:
		$FishingArea3.visible = true
		$FishingArea3.get_node("CollisionShape2D").disabled = false 
	else:
		$FishingArea3.visible = false  
		$FishingArea3.get_node("CollisionShape2D").disabled = true 
	
	if GameData.plastic_population > 0:
		$TrashArea.visible = true
		$TrashArea.get_node("CollisionShape2D").disabled = false 
	else:
		$TrashArea.visible = false
		$TrashArea.get_node("CollisionShape2D").disabled = true
	
	if GameData.plastic_population > 5:
		$TrashArea2.visible = true
		$TrashArea2.get_node("CollisionShape2D").disabled = false 
	else:
		$TrashArea2.visible = false
		$TrashArea2.get_node("CollisionShape2D").disabled = true


func _process(delta: float) -> void:
	if GameData.fish_population > 0:
		$FishingArea.visible = true 
		$FishingArea.get_node("CollisionShape2D").disabled = false  
	else:
		$FishingArea.visible = false
		$FishingArea.get_node("CollisionShape2D").disabled = true
		
	if GameData.fish_population > 10:
		$FishingArea2.visible = true 
		$FishingArea2.get_node("CollisionShape2D").disabled = false  
	else:
		$FishingArea2.visible = false
		$FishingArea2.get_node("CollisionShape2D").disabled = true  

	
	if GameData.fish_population > 20:
		$FishingArea3.visible = true
		$FishingArea3.get_node("CollisionShape2D").disabled = false 
	else:
		$FishingArea3.visible = false
		$FishingArea3.get_node("CollisionShape2D").disabled = true  

	if GameData.plastic_population > 0:
		$TrashArea.visible = true
		$TrashArea.get_node("CollisionShape2D").disabled = false 
	else:
		$TrashArea.visible = false
		$TrashArea.get_node("CollisionShape2D").disabled = true
	
	if GameData.plastic_population > 5:
		$TrashArea2.visible = true
		$TrashArea2.get_node("CollisionShape2D").disabled = false 
	else:
		$TrashArea2.visible = false
		$TrashArea2.get_node("CollisionShape2D").disabled = true
