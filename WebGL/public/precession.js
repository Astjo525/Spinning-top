export function precession(object, angle) {
   
    //Roterar containern runt y-axeln, vilket blir v�rldens y-axel
    object.parent.rotation.y = angle;
   
};
