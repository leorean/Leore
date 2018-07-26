var _s = string_split(argument0, '.');
var _n1 = real(_s[0]);
if (array_length_1d(_s) == 2) {
    var _n2 = power(10, (string_length(_s[1])));
    var _n3 = real(_s[1]);
    var _n4 = _n3 / _n2;
    return _n1 + _n4;
} else
    return _n1;
