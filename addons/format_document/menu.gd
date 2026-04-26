extends EditorContextMenuPlugin

var _format_current_document: Callable


func _init(cb) -> void:
	add_context_menu_item("Format Document", _format_current_document)
	_format_current_document = cb


func _popup_menu(paths: PackedStringArray) -> void:
	add_context_menu_item("Format Document", _format_current_document)
