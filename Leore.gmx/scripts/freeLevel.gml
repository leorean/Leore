if (!is_array(argument0)) exit;

var ds = argument0[0];
ds_grid_destroy(ds[0]);
ds_grid_destroy(ds[1]);
ds_grid_destroy(ds[2]);
ds_grid_destroy(ds[3]);
for(var i = 0; i < ds_list_size(argument0[1]); i++) {
    ds_map_destroy(ds_list_find_value(argument0[1], i));
}
ds_list_destroy(argument0[1]); // OBJ
ds_map_destroy(argument0[2]); // PROPS

