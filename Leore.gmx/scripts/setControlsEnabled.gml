/*if (!argument0) {
    for(var i = 0; i < array_length_1d(global.keys); i++) {
        global.keys[i] = false;
    }
}*/
if(!argument0)
    ds_map_clear(global.input);
