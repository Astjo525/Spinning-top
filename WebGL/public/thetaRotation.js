export function thetaRotation(object, angle) {
   
    //S�tter ordningen av vilka rotationer utf�rs f�rst
    object.parent.rotation.order = "YXZ";
    
    //Roterar containern, s� objektet roteras runt v�rldens x- och z-axel
    object.parent.rotation.z = angle;
    object.parent.rotation.x = angle;
   
};
