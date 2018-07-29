var _o = argument0;
with(_o) {
    
    instance_activate_object(objTrapSpawn);
    for (var i = 0; i < instance_number(objTrapSpawn); i++) {
        var ts = instance_find(objTrapSpawn, i);
        if (ts.type == type) {
            var e = instance_create(ts.x + 8, ts.y + 8, objEnemy);
            e.type = ts.enemyType;
        }        
    }

    instance_activate_object(objTrapBlock);
    for (var i = 0; i < instance_number(objTrapBlock); i++) {
        var tb = instance_find(objTrapBlock, i);
        if (tb.type == type) {
            tb.type = type;
            with(tb) { instance_create(x, y, objSolid) }
            tb.activated = true;
        }
    }
    
    activated = true;
}
