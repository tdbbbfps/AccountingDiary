extends Control
class_name Calender

@export var month_label : Label
@export var year_button : Button
@export var days_grid : GridContainer
var months : Array[String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
var current_month : int = 0:
	set(value):
		current_month = value
		month_label.text = months[current_month - 1]
var current_year : int = 0:
	set(value):
		current_year = value
		year_button.text = str(current_year)


func _ready() -> void:
	# Initialize current year and month
	current_year = get_date_param("year")
	current_month = get_date_param("month")
	generate_calender()

# year, month, day, weekday, hour, minute, second, and dst (Daylight Savings Time)
func get_date_param(param : String):
	return Time.get_datetime_dict_from_system()[param]

func generate_calender():
	for child in days_grid.get_children():
		child.queue_free()

	# Add blanks in front of the first day.
	for i in range(get_first_weekday()):
		var blank = Control.new()
		blank.custom_minimum_size = Vector2(32, 32)
		days_grid.add_child(blank)
	
	for i in range(1, get_days_in_month() + 1, 1):
		var day_button = Button.new()
		day_button.text = str(i)
		day_button.custom_minimum_size = Vector2(32, 32)
		days_grid.add_child(day_button)

# Turn to previous month
func _on_prev_month_btn_pressed() -> void:
	current_month -= 1
	if (current_month == 0):
		current_month = 12
		current_year -= 1
	generate_calender()
# Turn to next month
func _on_next_month_btn_pressed() -> void:
	current_month += 1
	if (current_month == 12):
		current_month = 1
		current_year += 1
	generate_calender()
# Get first the day of the first week of a month.
func get_first_weekday() -> int:
	var date = "%04d-%02d-01" % [current_year, current_month]
	return Time.get_datetime_dict_from_datetime_string(date, true)["weekday"]

# Return days by current_month
func get_days_in_month() -> int:
	var month_days = [31,28,31,30,31,30,31,31,30,31,30,31]
	# Return 29 if February and is leap year
	if (current_month == 2 && is_leap_year(current_year)):
		return 29
	return month_days[current_month - 1]

# Check if is leap year
func is_leap_year(year : int) -> bool:
	return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

func is_current_month() -> bool:
	var now = Time.get_date_dict_from_system()
	return current_year == now["year"] && current_month == now["month"]
