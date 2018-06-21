if (global.debug) {
    var _s = "[" + date_time_string(date_current_datetime()) + "]: ";
    for (var _i = 0; _i < argument_count; _i++) {
        _s += string(argument[_i]) + ", ";
    }
    show_debug_message(string_delete(_s, string_length(_s) - 1, 2));
}
