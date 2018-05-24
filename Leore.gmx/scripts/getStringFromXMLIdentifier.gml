// getStringFromXMLIdentifier(string, identifier)

var _id = argument1 + '="'
var _start = string_pos(_id, argument0) + string_length(_id);

var _sub = "";
for(var i = _start; i < string_length(argument0); i++) {
    var _c = string_copy(argument0, i, 1);    
    if (_c != '"')
        _sub += _c;
    else
        return _sub;
}
