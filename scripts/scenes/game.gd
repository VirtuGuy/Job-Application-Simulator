extends Node3D

# Nodes
@onready var camera: Camera3D = $Camera
@onready var camGamePos: Node3D = $CameraPoses/CamGamePos
@onready var camMenuPos: Node3D = $CameraPoses/CamMenuPos
@onready var pencilAnim: AnimationPlayer = $Map/PencilAnim
@onready var writingSound: AudioStreamPlayer = $Sounds/Writing
@onready var cryingSound: AudioStreamPlayer = $Sounds/Crying

# Control nodes
@onready var gameHUD: Control = $GameHUD
@onready var menuHUD: Control = $MenuHUD
@onready var endingsLabel: Label = $MenuHUD/EndingsPanel/EndingsLabel
@onready var secretButton: Button = $MenuHUD/MainPanel/SecretButton

# Variables
var sinFrame: float = 0
var camDur: float = 0.8

# Game/Menu variables
var gameStarted: bool = false
var cameraInPos: bool = false

func _ready():
	CoolStuff.loadData()
	
	endingsLabel.text = ""
	
	for ending in CoolStuff.endings.keys():
		var suffix: String = "No"
		if CoolStuff.data.endings.has(ending):
			suffix = "Yes"
		
		var endingName: String = CoolStuff.endings[ending].ending
		
		endingsLabel.text += "\"%s\" - %s\n" % [endingName, suffix]
	
	menu()

func _process(delta):
	if cameraInPos:
		camera.position.y += sin(delta * sinFrame) * (0.25 / 100.0)
		sinFrame += 5
		
func game():
	gameStarted = true
	menuHUD.visible = false
	
	var camTween: Tween = get_tree().create_tween()
	camTween.tween_property(camera, "transform", camGamePos.transform, camDur)
	camTween.connect("finished", func():
		cameraInPos = true
		gameHUD.visible = true
	)
	
func menu():
	gameStarted = false
	gameHUD.visible = false
	
	showPanel("MainPanel")
	
	camera.transform = camMenuPos.transform
	
	cameraInPos = false
	menuHUD.visible = true
	
	secretButton.visible = false
	
	if CoolStuff.data.endings.size() >= 2:
		secretButton.visible = true
	
func showPanel(panelName: String):
	for panel in menuHUD.get_children():
		if panel is Panel:
			panel.visible = false
			if panel.name == panelName:
				panel.visible = true

# Signals
func _on_start_button_pressed():
	game()
	
func _on_endings_button_pressed():
	showPanel("EndingsPanel")
	
func _on_credits_button_pressed():
	showPanel("CreditsPanel")

func _on_exit_button_pressed():
	get_tree().quit(0)
	
func _on_secret_button_pressed():
	SceneManager.changeScene("minigame")

func _on_endings_back_pressed():
	showPanel("MainPanel")
	
func _on_credits_back_pressed():
	showPanel("MainPanel")

func _on_choice_1_pressed():
	writingSound.play()
	pencilAnim.play("Write")
	gameHUD.visible = false
	
	CoolStuff.endingName = "good"
	SceneManager.changeScene("ending", 0.08)

func _on_choice_2_pressed():
	cryingSound.play()
	gameHUD.visible = false
	
	CoolStuff.endingName = "sad"
	SceneManager.changeScene("ending", 0.08)
