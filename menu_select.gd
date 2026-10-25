class_name MenuSelect
extends Control

var index: int = 0

@export var wheel_images: Array[Texture2D]

@onready var wheel: TextureRect = $Wheel


func _ready() -> void:
	visible = false;
	
const NumberOfItems: int = 5;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_menu") and !visible:
		visible = true;
		index = index;
	elif (event.is_action_pressed("toggle_menu") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) ) and visible:
		visible = false;
	elif visible and event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			scroll(1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			scroll(-1)
			
func scroll(num: int) -> void:
	index = wrapi(index + num, 0, NumberOfItems)
	wheel.texture = wheel_images[index]
	print(index)
