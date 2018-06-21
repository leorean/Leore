for (var _i = 0; _i < array_length_1d(argument[0]); _i++) {
    for(var _j = 1; _j < argument_count; _j++) {
        if (get(argument[0], _i) == argument[_j])
            return true;
    }
}
return false;
