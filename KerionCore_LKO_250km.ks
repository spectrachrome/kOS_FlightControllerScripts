// A launch sequence which puts the Kerion core spacecraft into a circular orbit 250km above Kerbin.

CLEARSCREEN.
PRINT "Starting countdown".

LOCK THROTTLE TO 1.0.

FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT countdown.
    WAIT 1.
}

// This is a trigger definition that constantly checks to see if our thrust is zero. If it is, 
// it will attempt to stage and then return to where the script left off. The PRESERVE keyword 
// keeps the trigger active even after it has been triggered.
WHEN MAXTHRUST = 0 THEN {
    PRINT "Staging".
    STAGE.
    PRESERVE.
}.

SET STEER TO HEADING(90,90).
LOCK STEERING TO STEER.

// Set the apoapsis at 250 kilometers above Kerbin.
UNTIL SHIP:APOAPSIS > 250000 {
    SET CURRENT_ALTITUDE_GROUND TO ROUND(MAX(0.001, ((ALTITUDE-GEOPOSITION:TERRAINHEIGHT) - 100)),3).
    // This equation was taken from the Wikipedia article for the `y` parameter of the cycloid curve
    // and resolved for `t` to get the tilt angle in radians for the current altitude.
    SET STEER TO HEADING(90, ARCSIN(1 - CURRENT_ALTITUDE_GROUND / 125000)).
}.

// NOTE that it is vital to not just let the script end right away
// here.  Once a kOS script just ends, it releases all the controls
// back to manual piloting so that you can fly the ship by hand again.
// If the program just ended here, then that would cause the throttle
// to turn back off again right away and nothing would happen.


