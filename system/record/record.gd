extends Control
class_name Record

var date : String
@export var type : String = "Food"
@export_multiline var description : String = "Description"
@export var money : int = 0
@onready var record_icon: TextureRect = $HBoxContainer/RecordIcon
@onready var record_description: Label = $HBoxContainer/RecordDescription
@onready var record_money: Label = $HBoxContainer/RecordMoney

#func _ready() -> void:
	#set_record()

func set_record(date : String, type : String, description : String, money : int):
	record_description.text = description
	if (money > 0): record_money.text = "$+%d" %money
	else: record_money.text = "$%d" %money
