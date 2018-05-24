// getStringFromXMLIdentifier(string, identifier)

// <object name="Player" type="Player" x="176" y="96" width="16" height="16"/>
var _start = string_pos(argument1, argument0) + string_length(argument1);

// Player" x="176" y="96" width="16" height="16"/>
var _sub = string_delete(argument0, 0, _start);

