## Godot Code Formatter

- Adds "Format Document" to code context menu
- Adds "Format Document" command to command palette
- Adds "Format Document" to "Project > Tools"

### Setup

1. Download and add this addon to your project
2. Download a formatter. [Here's GDScript's formatter](https://github.com/GDQuest/GDScript-formatter/releases/)
3. Unzip and either put "gdscript-formatter.exe" in your path OR specify the full path inside `res://addons/format_document/plugin.cfg`

```ini
command="gdscript-formatter.exe"
# or
command="/path/to/formatter/gdscript-formatter.exe"
```
