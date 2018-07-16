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

dsIgnore = ds_list_create();

// tiles
for (var i = 0; i<w; i ++)
{
    for (var j = 0; j<h; j++)
    {
        bg = ds_grid_get(data[0],i,j);
        water = ds_grid_get(data[1],i,j);
        fg = ds_grid_get(data[2],i,j);
        top = ds_grid_get(data[3],i,j);

        switch (water) {//water tiles
            case -1: // nothing
            break;
            case 618:
                //instance_create(i*TILE, j*TILE, objSolid);
            default:
                var t = addTile(water, i*TILE, j*TILE, LAYER_WATER);
                //tile_set_alpha(t, .7);
            break;
        }
        switch(bg) {
            case -1: case 0: // nothing
            break;
            // stairs
            case 59: case 106: case 153: case 200:
            case 293: case 294: case 340: case 341:
            case 909: case 956:
                instance_create(i*TILE, j*TILE, objStairs);
            default:
                addTile(bg, i*TILE, j*TILE, LAYER_BG);
            break;

        }
        switch(top) {
            case -1: //nothing
            break;
            // trees
            // 2 x 3
            case 520:
            case 805:
            case 624:
                var tree = instance_create(i*TILE, j*TILE, objTree);
                tree.w = 2;
                tree.h = 3;
                tree.tile = top;
            break;
            // 1 x 2
            case 807:
                var tree = instance_create(i*TILE, j*TILE, objTree);
                tree.w = 1;
                tree.h = 2;
                tree.tile = top;
            break;
            // 3 x 4
            case 668:
                var tree = instance_create(i*TILE, j*TILE, objTree);
                tree.w = 3;
                tree.h = 4;
                tree.tile = top;
            break;
            default:
                addTile(top, i*TILE, j*TILE, LAYER_TOP);
            break;
        }

        switch(fg) {
            case -1: // nothing
            break;
            case 0:
                var destroyable = instance_create(i*TILE + TILE/2, j*TILE + TILE/2, objDestroyable);
                destroyable.hp = 1;
                destroyable.type = 0;
            break;
            case 1:
                var destroyable = instance_create(i*TILE + TILE/2, j*TILE + TILE/2, objDestroyable);
                destroyable.hp = 2;
                destroyable.type = 1;
            break;
            case 2: // solid (invisible)
                instance_create(i*TILE, j*TILE, objSolid);
            break;
            case 104: // cliffs
                instance_create(i*TILE, j*TILE, objCliff);
                addTile(fg, i*TILE, j*TILE, LAYER_FG);
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
            // so this is done only once!
            // this means, the first level the game loads, must have a player!
            if(!global.mapX && !global.mapY) {
                global.mapX = obj_x + 8;
                global.mapY = obj_y + 8;
            }
        break;
        case "door":
            var door = instance_create(obj_x, obj_y, objDoor);
            door.tx = real(ds_map_find_value(obj, "tx"));
            door.ty = real(ds_map_find_value(obj, "ty"));
            door.target = ds_map_find_value(obj, "target");
            var ddir = ds_map_find_value(obj, "dir");
            switch(ddir) {
                case "up": door.dir = UP; break;
                case "down": door.dir = DOWN; break;
                case "left": door.dir = LEFT; break;
                case "right": door.dir = RIGHT; break;
            }
            door.targetdir = ds_map_find_value(obj, "targetdir");            
        break;
        case "sign":
            var sgn = instance_create(obj_x, obj_y, objSign);
            sgn.text = string_split(ds_map_find_value(obj, "text"), "|");
        break;
        case "enemy":
            var e = instance_create(obj_x + 8, obj_y + 8, objEnemy);
            e.type = real(ds_map_find_value(obj, "type"));
        break;
    }
}

ds_list_destroy(dsIgnore);
