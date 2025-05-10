extends CanvasLayer

@onready var key_count: Label = $Panel/keyCount
var isOn = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("openInventory"):
		#Opening inventory system
		key_count.text = "Keys: " + str(LeGame.inventory["key_count"])
		if isOn:
			visible = false
			isOn = false
		else:
			visible = true
			isOn = true
