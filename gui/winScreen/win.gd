extends Control

signal reset

func _on_button_pressed() -> void:
	emit_signal("reset")
