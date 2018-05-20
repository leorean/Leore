/// createLevel(levelmap);

var data = argument0;

var w = ds_grid_width(data[0]);
var h = ds_grid_height(data[0]);

var fg = 0;
var bg = 0;
var obj = 0;

if (room_width!=w*TILE || room_height!=h*TILE)
{
    room_set_width(room,w*TILE);
    room_set_height(room,h*TILE);
    room_restart();
    exit;
}

for (var i = 0; i<w; i ++)
{
    for (var j = 0; j<h; j++)
    {
        bg = ds_grid_get(data[0],i,j);
        fg = ds_grid_get(data[1],i,j);
        top = ds_grid_get(data[2],i,j);
        obj = ds_grid_get(data[3],i,j);

        if (bg > 0) //bg tiles
            addTile(bg, i*TILE, j*TILE, LAYER_BG);
        if (fg > 0) {//fg tiles (+ solid)
            addTile(fg, i*TILE, j*TILE, LAYER_FG);
            instance_create(i*TILE, j*TILE, objSolid);
        }
        if (top > 0) //top tiles
            addTile(top, i*TILE, j*TILE, LAYER_TOP);
            
        switch (obj)
        {
            case 0: //
            //instance_create(i*TILE, j*TILE, objSolid);
            break;
        }
    }
}