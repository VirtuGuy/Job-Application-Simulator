extends Control

# Nodes
@onready var titleLabel: Label = $TitleLabel
@onready var endingLabel: Label = $EndingLabel
@onready var goodMusic: AudioStreamPlayer = $Sounds/GoodMusic
@onready var sadMusic: AudioStreamPlayer = $Sounds/SadMusic

func _ready():
	if CoolStuff.endings.has(CoolStuff.endingName):
		var ending = CoolStuff.endings[CoolStuff.endingName]
		var totalEndings: int = CoolStuff.endings.size()
		var endingNum: int = ending.endingNumber
		var endingName: String = ending.ending
		
		endingLabel.text = "Ending %d/%d - \"%s\"" % [endingNum, totalEndings,
		endingName]
		
		match CoolStuff.endingName:
			"good":
				goodMusic.play()
			"sad":
				titleLabel.text = "Congrats?"
				sadMusic.play()
		
		if not CoolStuff.data.endings.has(endingName):
			CoolStuff.data.endings.append(CoolStuff.endingName)
			CoolStuff.saveData()

func _on_menu_button_pressed():
	SceneManager.changeScene("game")
