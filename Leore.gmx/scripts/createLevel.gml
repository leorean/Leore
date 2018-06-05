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

        if (bg > 0) //bg tiles
            addTile(bg, i*TILE, j*TILE, LAYER_BG);

        if (water > 0) {//water tiles
            var t = addTile(water, i*TILE, j*TILE, LAYER_WATER);
            tile_set_alpha(t, .6);
        }
        
        if (top > 0) //top tiles
            addTile(top, i*TILE, j*TILE, LAYER_TOP);

        switch(fg) {
            case -1: // nothing
            break;
            case 0:
                var destroyable = instance_create(i*TILE, j*TILE, objDestroyable);
                destroyable.hp = 1;
                destroyable.type = 0;
            break;
            case 1:
                var destroyable = instance_create(i*TILE, j*TILE, objDestroyable);
                destroyable.hp = 2;
                destroyable.type = 1;
            break;
             // holes
            case 282: case 283: case 284:
            case 329: case 330: case 331:
            case 376: case 377: case 378:
            case 423: case 424: case 425:
            case 470: case 471: case 472:
            case 517: case 518: case 519:
            case 564: case 565: case 566:
            
                addTile(fg, i*TILE, j*TILE, LAYER_FG);
                instance_create(i*TILE, j*TILE, objHole);
            break;
            default:
                addTile(fg, i*TILE, j*TILE, LAYER_FG);
                instance_create(i*TILE, j*TILE, objSolid);
            break;
        }
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
            instance_create(obj_x + 8, obj_y + 8, objPlayer);
        break;
        case "door":
            var door = instance_create(obj_x, obj_y, objDoor);
            door.tx = real(ds_map_find_value(obj, "tx"));
            door.ty = real(ds_map_find_value(obj, "ty"));
            door.target = ds_map_find_value(obj, "target");
        break;
    }
}
