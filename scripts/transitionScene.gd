extends CanvasLayer
@onready var color_rect = $ColorRect
@onready var animatransition = $animatransition



func load_scene(target_scene,animation):
	animatransition.play(animation)
	await animatransition.animation_finished
	get_tree().change_scene_to_file(target_scene)
	animatransition.play_backwards(animation)
	await animatransition.animation_finished
	animatransition.play("RESET")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
