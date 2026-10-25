extends TileMapLayer

@export var menu: MenuSelect 
@onready var outline: Sprite2D = $Outline
const Source_ID: int = 0;
const Dirt: Vector2i = Vector2i(0,0);
const Grass: Vector2i = Vector2i(1,0);
const Stone: Vector2i = Vector2i(2,0);
const Sand: Vector2i = Vector2i(3,0);
var Bulldozing: bool = false
var Tile: Vector2i = Vector2i(0,0);

@onready var place_sound: AudioStreamPlayer = $PlaceSound
@onready var destroy_sound: AudioStreamPlayer = $DestroySound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(-1, 2):
		for y in range(-1, 2):
			set_cell(Vector2i(x,y),Source_ID, Grass);
			
			


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_1:
		Tile = Dirt;
		Bulldozing = 0;
	if event is InputEventKey and event.pressed and event.keycode == KEY_2:
		Tile = Grass;
		Bulldozing = 0;
	if event is InputEventKey and event.pressed and event.keycode == KEY_3:
		Tile = Stone;
		Bulldozing = 0;
	if event is InputEventKey and event.pressed and event.keycode == KEY_4:
		Tile = Sand;
		Bulldozing = 0;
	if event is InputEventKey and event.pressed and event.keycode == KEY_0:
		Bulldozing = 1;
	
func _process(_delta: float) -> void:
	if menu.visible:
		Bulldozing = menu.index == 4
		Tile = Vector2i(menu.index, 0)
		return
	var Cell: Vector2i = local_to_map(get_local_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if !Bulldozing:
			if get_cell_atlas_coords(Cell) != Tile:
				place_sound.play();
			set_cell(Cell, Source_ID, Tile)
		else:
			if get_cell_source_id(Cell) != -1:
				destroy_sound.play();
			erase_cell(Cell)
	var CurrentCellPosition: Vector2i = map_to_local(Cell);
	
	if get_cell_source_id(Cell) != -1:
		outline.position = CurrentCellPosition;
		outline.z_index = 1;
	else:
		outline.position = CurrentCellPosition + Vector2i(0,16);
		outline.z_index = -1;
	
			
