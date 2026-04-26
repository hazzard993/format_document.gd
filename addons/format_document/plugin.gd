@tool
extends EditorPlugin

var _menu: EditorContextMenuPlugin


func _enter_tree() -> void:
	_on()


func _exit_tree() -> void:
	_off()


func _on() -> void:
	add_tool_menu_item("Format Document", _format_current_document.bind(0))

	_menu = preload("res://addons/format_document/menu.gd").new(_format_current_document)
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCRIPT_EDITOR_CODE, _menu)

	EditorInterface.get_command_palette().add_command(
		"Format Document",
		"format_document",
		_format_current_document.bind(0),
	)


func _off() -> void:
	remove_tool_menu_item("Format Document")
	remove_context_menu_plugin(_menu)
	EditorInterface.get_command_palette().remove_command("format_document")


func _format_current_document(x: Variant) -> void:
	var cfg = ConfigFile.new()
	cfg.load("res://addons/format_document/plugin.cfg")
	var command = cfg.get_value("plugin", "command")
	if command == null:
		print("format_document/command has not been specified")
		return

	var script_editor = EditorInterface.get_script_editor()
	var current_script := script_editor.get_current_script()
	var path := ProjectSettings.globalize_path(current_script.get_path())

	OS.execute(command, [path])

	var file := FileAccess.open(path, FileAccess.READ)
	var new_text := file.get_as_text()
	file.close()

	var editor := script_editor.get_current_editor()
	var code_edit = editor.get_base_editor() as CodeEdit
	var col := code_edit.get_caret_column()
	var line := code_edit.get_caret_line()
	var first_line := code_edit.get_first_visible_line()
	code_edit.set_text(new_text)
	code_edit.set_caret_line(line)
	code_edit.set_caret_column(col)
	code_edit.set_line_as_first_visible(first_line)
	code_edit.tag_saved_version()
