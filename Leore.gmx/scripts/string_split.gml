var _msg = argument0; //string to split
var _splitBy = argument1; //string to split the first string by
var _slot = 0;
var _splits; //array to hold all _splits
var _str2 = ""; //var to hold the current split we're working on building

if (string_length(_msg) == 0) exit;

var _i;
for (_i = 1; _i < (string_length(_msg)+1); _i++) {
    var _currStr = string_copy(_msg, _i, 1);
    if (_currStr == _splitBy) {
        _splits[_slot] = _str2; //add this split to the array of all _splits
        _slot++;
        _str2 = "";
    } else {
        _str2 = _str2 + _currStr;
        _splits[_slot] = _str2;
    }
}
return _splits;
