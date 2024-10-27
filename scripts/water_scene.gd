# water_scene.gd
extends Node2D

@onready var water_area: Sprite2D = $WaterArea

func _ready():
	if !water_area:
		push_error("WaterArea node not found!")
		return
		
	var water_material = water_area.material as ShaderMaterial
	if !water_material:
		push_error("ShaderMaterial not found on WaterArea!")
		return
	
	# Generate and set up textures
	_generate_textures(water_material)
	
	# Set up initial parameters
	_setup_water_parameters(water_material)
	
	# Set aspect ratio
	_update_aspect_ratio(water_material)

func _generate_textures(material: ShaderMaterial) -> void:
	# Create water depth gradient
	var gradient_colors: Array[Color] = [
		Color(0.125, 0.286, 0.502, 1.0),  # Deep water
		Color(0.337, 0.616, 0.835, 1.0)   # Shallow water
	]
	material.set_shader_parameter("waterDepthGradient", _create_gradient_texture(gradient_colors))
	
	# Create the noise textures
	material.set_shader_parameter("causticTexture", _create_noise("simplex"))
	material.set_shader_parameter("causticHighlightTexture", _create_noise("cellular"))
	material.set_shader_parameter("causticNoiseTexture", _create_noise("perlin"))
	material.set_shader_parameter("causticFadeNoiseTexture", _create_noise("simplex"))
	material.set_shader_parameter("specularNoiseTexture", _create_noise("perlin"))
	material.set_shader_parameter("specularMovementLeftNoiseTexture", _create_noise("simplex"))
	material.set_shader_parameter("specularMovementRightNoiseTexture", _create_noise("simplex"))
	material.set_shader_parameter("foamTexture", _create_noise("cellular"))

func _create_noise(noise_type: String) -> ImageTexture:
	var noise = FastNoiseLite.new()
	var image = Image.create(512, 512, false, Image.FORMAT_RGBA8)
	
	match noise_type:
		"simplex":
			noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
			noise.frequency = 0.015
		"perlin":
			noise.noise_type = FastNoiseLite.TYPE_PERLIN
			noise.frequency = 0.02
		"cellular":
			noise.noise_type = FastNoiseLite.TYPE_CELLULAR
			noise.frequency = 0.025
	
	noise.seed = randi()  # Random seed for variety
	
	image.lock()
	for x in range(512):
		for y in range(512):
			var val = (noise.get_noise_2d(float(x), float(y)) + 1.0) / 2.0
			image.set_pixel(x, y, Color(val, val, val, 1.0))
	image.unlock()
	
	return ImageTexture.create_from_image(image)

func _create_gradient_texture(colors: Array[Color]) -> ImageTexture:
	var image = Image.create(256, 1, false, Image.FORMAT_RGBA8)
	image.lock()
	
	for x in range(256):
		var t = float(x) / 255.0
		var color = colors[0].lerp(colors[1], t)
		image.set_pixel(x, 0, color)
	image.unlock()
	
	return ImageTexture.create_from_image(image)

func _setup_water_parameters(material: ShaderMaterial) -> void:
	var params = {
		"pixelization": 2048.0,
		"generalTransparency": 0.9,
		"causticColor": Color(0.455, 0.773, 0.765, 1.0),
		"causticHighlightColor": Color(0.741, 0.894, 0.898, 1.0),
		"causticScale": 12.0,
		"causticSpeed": 0.005,
		"causticMovementAmount": 0.15,
		"causticFaderMultiplier": 1.45,
		"specularColor": Color(1.0, 1.0, 1.0, 1.0),
		"specularThreshold": 0.35,
		"specularSpeed": 0.025,
		"specularScale": 15.0,
		"foamColor": Color(1.0, 1.0, 1.0, 1.0),
		"foamIntensity": 0.2,
		"foamScale": 15.0,
		"outlineColor": Color(0.675, 0.86, 1.0, 1.0)
	}
	
	for param in params:
		material.set_shader_parameter(param, params[param])

func _update_aspect_ratio(material: ShaderMaterial) -> void:
	var texture = water_area.texture
	if texture:
		var aspect = float(texture.get_height()) / float(texture.get_width())
		material.set_shader_parameter("aspectRatio", aspect)

# Optional: Create base texture if needed
func _create_base_water_texture() -> ImageTexture:
	var image = Image.create(1024, 1024, false, Image.FORMAT_RGBA8)
	image.fill(Color(0, 0, 1, 0.5))
	return ImageTexture.create_from_image(image)
