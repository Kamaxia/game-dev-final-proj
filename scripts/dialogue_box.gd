extends CanvasLayer
const dialogue = {
	"Robot Guy1" : {
		1 : "Ahh, another traveler hmm ... welcome to whats left.",
		2 : "What a shame this world came to what it was, but maybe theres hope left.",
		3 : "I'm sure you're looking for a way out ... aren't we all. 
		Search for the keys, they'll open the path to your destination."
	},
	"MC" : {
		1 : "Could you tell me where exactly I am... ",
		2 : "Yea I've seen how the world is ... I still don't know where the hell I am.",
		3 : "Grab some keys and go huh, thanks I guess."
	}
}

var dialogueTracker = {
	"Robot Guy1" : 1,
}
@onready var character: Sprite2D = $Panel/Character
@onready var dialogueDisplay: Label = $Panel/Dialogue
var robotTexture = load("res://assets/robotDefault.webp")
var MCTexture = load("res://assets/MCDefault.webp")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func playDialogue(char, MCtracker = 1):
	print("Displaying text")
	visible = true
	if char == "Robot Guy1":
		character.texture = robotTexture
	elif char == "MC":
		character.texture = MCTexture
		
	if dialogueTracker[char] <= dialogue[char].size():
		dialogueDisplay.text = dialogue[char][dialogueTracker[char]]
		dialogueTracker[char] += 1
	else:
		visible = false
		dialogueTracker[char] = 1
