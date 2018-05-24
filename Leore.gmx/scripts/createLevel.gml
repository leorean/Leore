/// createLevel(levelmap);

var data = argument0[0];
var objects = argument0[1];

var w = ds_grid_width(data[0]);
var h = ds_grid_height(data[0]);

var bg = 0;
var fg = 0;
var water = 0;
var top = 0;
var obj = 0;

if (room_width!=w*TILE || room_height!=h*TILE)
{
    room_set_width(room,w*TILE);
    room_set_height(room,h*TILE);
    room_restart();
    exit;
}

// tiles
for (var i = 0; i<w; i ++)
{
    for (var j = 0; j<h; j++)
    {
        bg = ds_grid_get(data[0],i,j);
        fg = ds_grid_get(data[1],i,j);
        water = ds_grid_get(data[2],i,j);
        top = ds_grid_get(data[3],i,j);
        //obj = ds_grid_get(data[4],i,j);

        if (bg > 0) //bg tiles
            addTile(bg, i*TILE, j*TILE, LAYER_BG);
        if (fg > 0) {//fg tiles (+ solid)
            addTile(fg, i*TILE, j*TILE, LAYER_FG);
            //instance_create(i*TILE, j*TILE, objSolid); <- handling collision by tile finding?
        }
        if (water > 0) {//water tiles
            var t = addTile(water, i*TILE, j*TILE, LAYER_WATER);
            tile_set_alpha(t, .6);
        }
        
        if (top > 0) //top tiles
            addTile(top, i*TILE, j*TILE, LAYER_TOP);
    }
}

// objects
for (var i = 0; i < ds_list_size(objects); i++) {
    var obj = ds_list_find_value(objects, i);
    
    var obj_type = ds_map_find_value(obj, "type");
    var obj_x = real(ds_map_find_value(obj, "x"));
    var obj_y = real(ds_map_find_value(obj, "y"));
    
    switch(obj_type) {
        case "player":
            instance_create(obj_x, obj_y, objPlayer);
            
        break;
    }
}
