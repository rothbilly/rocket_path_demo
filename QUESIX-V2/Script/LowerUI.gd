extends Control

var _energy :int = 3
var active_panel :int = 0
var _energy_load :int = 0

export(Array, NodePath) onready var movements


func _ready():
	initiial_movements()
	set_active(active_panel)
	
	EventController.connect("_add_coin",self,"add_energy")
	pass


func initiial_movements():
	for index in movements.size():
		var panel = get_node(movements[index]) as MovementIndicator
		panel.setup_action(MovementIndicator.ACTION.nothing)
		if index < _energy:
			panel.setup_state(MovementIndicator.STATE.active)
		else:
			panel.setup_state(MovementIndicator.STATE.blocked)
		movements[index] = panel


func set_active(index):
	movements[index].setup_state(MovementIndicator.STATE.selected)
	if index > 0:
		movements[index-1].setup_state(MovementIndicator.STATE.active)


func select_next():
	active_panel = clamp(active_panel + 1, 0, _energy-1)
	set_active(active_panel)


func clear_panel():
	_check_upgrade()
	for i in range(_energy):
		movements[i].setup_action(MovementIndicator.ACTION.nothing)
		movements[i].setup_state(MovementIndicator.STATE.active)


func reset_select():
	active_panel = 0
	set_active(active_panel)

func set_action(_action: int):
	if active_panel < _energy:
		movements[active_panel].setup_action(_action)

func clear_all():
	for movement in movements:
		movement.setup_action(MovementIndicator.ACTION.nothing)


func execute_movements():
	EventController.emit_signal("_on_movement_state", true)
	hide_ui(true)
	for movement in movements:
		if movement.action == MovementIndicator.ACTION.left:
			EventController.emit_signal("left_button", false)
			yield(get_tree().create_timer(0.5),"timeout")
		if movement.action == MovementIndicator.ACTION.go:
			EventController.emit_signal("front_button", Vector2(0,-1))
			yield(get_tree().create_timer(0.5),"timeout")
		if movement.action == MovementIndicator.ACTION.right:
			EventController.emit_signal("right_button", true)
			yield(get_tree().create_timer(0.5),"timeout")
	clear_panel()
	reset_select()
	EventController.emit_signal("_on_movement_state", false)
	hide_ui(false)
	
func add_energy(energy):
	_energy_load +=1
	
	
func _check_upgrade():
	if _energy_load >= _energy:
		_energy += 1
		_energy_load = 0
		
	
#----------------------Input Actions------------------
func _on_Left_pressed():
	#EventController.emit_signal("left_button", false)
	set_action(MovementIndicator.ACTION.left)
	select_next()


func _on_Move_pressed():
	#EventController.emit_signal("front_button", Vector2(0,-1))
	set_action(MovementIndicator.ACTION.go)
	select_next()


func _on_Right_pressed():
	set_action(MovementIndicator.ACTION.right)
	select_next()


func _on_Moverse_pressed():
	if active_panel > 0 :
		execute_movements()

	pass # Replace with function body.


func _on_Limpiar_pressed():
	clear_all()
	reset_select()
	pass # Replace with function body.
	
#------------------------- UI ---------------------

func hide_ui(state: bool):
	if state:
		$ButtonsRect/PanelContainer2/HBoxContainer/Moverse.set_disabled(true)
		$ButtonsRect.set_modulate(Color(0.6,0.6,0.6,1))
	else:
		$ButtonsRect.set_modulate(Color(1,1,1,1))
		$ButtonsRect/PanelContainer2/HBoxContainer/Moverse.set_disabled(false)
