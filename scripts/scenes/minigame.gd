extends Node2D

# Nodes
@onready var exitSpots: Node2D = $ExitSpots

func _ready():
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	
	var randNum: int = rng.randi_range(0, exitSpots.get_children().size() - 1)
	var chosenNode: Node = exitSpots.get_child(randNum)
	
	for exit in exitSpots.get_children():
		if exit is Node2D:
			exit.get_node("Area").connect("body_entered", func(body: Node2D):
				if body.name == "Player":
					exit.queue_free()
					CoolStuff.endingName = "secret"
					SceneManager.changeScene("ending")
			)
			if not exit == chosenNode:
				exit.queue_free()
