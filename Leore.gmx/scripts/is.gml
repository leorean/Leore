/// is (the instance or type, the parent instance or parent type)
return 
    object_is_ancestor(argument0, argument1)
    || object_is_ancestor(argument0.object_index, argument1)
    || (instance_exists(argument1) && object_is_ancestor(argument0, argument1.object_index))
    || (instance_exists(argument1) && object_is_ancestor(argument0.object_index, argument1.object_index))
    
    || argument0.object_index == argument1
    || (instance_exists(argument1) && argument0.object_index == argument1.object_index)
    ;
