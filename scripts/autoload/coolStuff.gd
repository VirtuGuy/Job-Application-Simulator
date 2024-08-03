extends Node

# Ending variables
var endingName: String = ""
var endings: Dictionary = {
	"good" = {
		ending = "Good Ending",
		endingNumber = 1
	},
	"sad" = {
		ending = "Sad Ending",
		endingNumber = 2
	},
	"secret" = {
		ending = "Secret Ending",
		endingNumber = 3
	}
}

# Save/Load functions
const saveFile: String = "user://jaSimData.save"

var data = {
	"endings": []
}

func saveData():
	var save = FileAccess.open(saveFile, FileAccess.WRITE)
	var json: String = JSON.stringify(data, "\t")
	save.store_string(json)
	
func loadData():
	if not FileAccess.file_exists(saveFile):
		return
		
	var save = FileAccess.open(saveFile, FileAccess.READ)
	var jsonString: String = save.get_as_text()
	
	var json: JSON = JSON.new()
	var parsedJson = json.parse(jsonString)
	if not parsedJson == OK:
		print("DATA JSON PARSE ERROR: ", json.get_error_message())
		return
	
	data = JSON.parse_string(jsonString)
