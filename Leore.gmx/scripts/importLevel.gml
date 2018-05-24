var file;

ds[0] = ds_grid_create(1, 1); //BG
ds[1] = ds_grid_create(1, 1); // FG
ds[2] = ds_grid_create(1, 1); // WATER
ds[3] = ds_grid_create(1, 1); // TOP
obj = ds_list_create(); //OBJ
    
if (file_exists(argument0))
    file = file_text_open_read(argument0);
else {
    show_debug_message("File " + string(argument0) + " doesn't exist");
    exit;
}

var f, i, j, w, h, l;

i = 0;j = 0; l = 0;

w = 1;
h = 1;

while (!file_text_eof(file)) {

    f = file_text_read_string(file);
    file_text_readln(file);
    
    if (w == 1 && string_pos('width="', f) != 0) {
        var str = string_copy(f, string_pos('width="', f) + 7, 5);
        w = real(string_digits(str));
        for (var d = 0; d < 4; d++)
            ds_grid_resize(ds[d], w, h);
    }
    if (h == 1 && string_pos('height="', f) != 0) {
        var str = string_copy(f, string_pos('height="', f) + 8, 5);
        h = real(string_digits(str));
        for (var d = 0; d < 4; d++)
            ds_grid_resize(ds[d], w, h);        
    }
    
    if (string_pos('<tile gid=', f) != 0) {
        ds_grid_add(ds[l], i, j, real(string_digits(f)) - 1);
        i++;
        if (i >= w) {
            i = 0;
            j++;
        }

        if (j >= h) {
            l++;
            j = 0;
        }        
    }
    
    // parsing objects
    if (string_pos('<object ', f) != 0) {    
        var o_type = getStringFromXMLIdentifier(f, 'type');

        mObject = ds_map_create();
        var o_x = getStringFromXMLIdentifier(f, 'x');
        var o_y = getStringFromXMLIdentifier(f, 'y');

        ds_map_add(mObject, "type", o_type);
        ds_map_add(mObject, "x", o_x);
        ds_map_add(mObject, "y", o_y);
        
        if (string_pos('/>', f) != 0) {
            ds_list_add(obj, mObject);
        }
    }
    if (string_pos('<property ', f) != 0) {
        var o_prop_name = getStringFromXMLIdentifier(f, 'name');
        var o_prop_value = getStringFromXMLIdentifier(f, 'value');
        
        ds_map_add(mObject, o_prop_name, o_prop_value);
    }
    if (string_pos('</properties>', f) != 0) {
        ds_list_add(obj, mObject);
    }
}

file_text_close(file);
return array(ds, obj);
