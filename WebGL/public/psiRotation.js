export function psiRotation(object, angle) {
   
    //Bestämmer axlarnas rotationsordning till först rotation runt z, sen x, sen y
    object.parent.children["3"].rotation.order = "ZXY"

    //Sätter rotation runt egen axel.
    object.parent.children["3"].rotation.y = angle;
   
};