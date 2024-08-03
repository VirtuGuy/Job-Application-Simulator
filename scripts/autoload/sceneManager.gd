extends CanvasLayer

# Nodes
@onready var fade: ColorRect = $Fade
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

func changeScene(sceneName: String, fadeInSpeed: float = 1):
	fade.visible = true
	animPlayer.play("Fade", -1, fadeInSpeed)
	
	await(animPlayer.animation_finished)
	get_tree().change_scene_to_file("res://scenes/%s.tscn" % sceneName)
	animPlayer.play_backwards("Fade", -1)
	
	await(animPlayer.animation_finished)
	fade.visible = false
