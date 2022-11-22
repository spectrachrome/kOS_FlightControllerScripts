// A launch sequence which puts the Kerion core spacecraft into a circular orbit 250km above Kerbin.

clearscreen.
print "Starting countdown".

function launch {
    sas off.
}

function executeManeuver {
    parameter utime, radial, normal, prograde.
    // Create a new meneuver from the given parameters and add it to the flight schedule.
    local m is node(utime, radial, normal, prograde).
    addManeuverToFlightPlan(m).
    local startTime is calculateStartTime(m).

    // Make sure we are aligned properly when the burn is about to begin.
    wait until startTime - 10.
    lockSteeringAtManeuverTarget(m).

    // Actually run the maneuver by firing the engines.
    wait until startTime.
    lock throttle to 1.0.
    wait until isManeuverComplete(m).
    lock throttle to 0.0.

    removeManeuverFromFlightPlan(m).
}

function addManeuverToFlightPlan {
    parameter m.
    add m.
}

function calculateStartTime {
    parameter m.
    local startTime is time:seconds + m:eta - maneuverBurnTime(m) / 2.
}

function lockSteeringAtManeuverTarget {
    parameter m.
    lock steering to m:burnvector.
}

function removeManeuverFromFlightPlan {
    parameter m.
    remove m.
}

function isManeuverComplete {
    parameter m.
    local currentVector is m:burnvector.

}

function getCurrentAltitude {
    local altitude is round(max(0.001, ((Altitude-Geoposition:TerrainHeight) - 100)),3).
}

function getCycloidAngleAtAltitude {
    local altitude is round(max(0.001, ((Altitude-Geoposition:TerrainHeight) - 100)),3).
}

rcs on.

lock throttle to 1.0.

from {local countdown is 10.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print countdown.
    wait 1.
}

//
////////////////////////////////
//
//  START

// This is a trigger definition that constantly checks to see if our thrust is zero. If it is,
// it will attempt to stage and then return to where the script left off. The PRESERVE keyword
// keeps the trigger active even after it has been triggered.
when MAXTHRUST = 0 then {
    print "Staging".
    stage.
    preserve.
}.

set steer to Heading(90, 90).
lock Steering to steer.

// Set the apoapsis at 250 kilometers above Kerbin.
until Ship:Apoapsis > 250000 {
    SET currentAltitude TO ROUND(MAX(0.001, ((Altitude-Geoposition:TerrainHeight) - 100)), 3).
    // This equation was taken from the Wikipedia article for the `y` parameter of the cycloid curve
    // and resolved for `t` to get the tilt angle in radians for the current altitude, which is then
    // converted to degrees and subtracted from 90. The resulting number represents how far the
    // joystick will pitch eastwards depending on altitude.
    //
    // 90 - acos(...) = asin(...)
    set steer to Heading(90, arcsin(1 - currentAltitude / 125000) * Constant:RadToDeg).
}.


set gravityParameter to Constant:G * Kerbin:Mass.
set r_apo to ship:apoapsis + 600000.
//Vis-viva equation to give speed we'll have at apoapsis.
set v_apo to sqrt(gravityParameter * ((2 / r_apo) - (1 / Ship:Orbit:SemiMajorAxis))).
//Vis-viva equation to calculate speed we want at apoapsis for a circular orbit. 
//For a circular orbit, desired SMA = radius of apoapsis.
set v_apo_wanted to sqrt(gravityParameter * ((2 / r_apo) - (1 / r_apo))). 
set circ_delta_v to v_apo_wanted - v_apo.

// The upper stage of the small probe burns 1849m/s in 79.4s, from which we can calculate our burn.
set burnTime to 79.4 * (circ_delta_v / 1849).

lock Steering to Prograde.

// Wait until we are half of the burn time before apoapsis, for an equal burn.
wait until Eta:Apoapsis < burnTime / 2.

lock throttle to 1.0.

wait until Ship:Periapsis >= 250000.

lock throttle to 0.0.

print "Eta Apoapsis:".
print Eta:Apoapsis.

// Upper stage fuel flow (even drain):
//
// LF: 131.106/sec
// Ox: 160.241/sec


// NOTE that it is vital to not just let the script end right away
// here.  Once a kOS script just ends, it releases all the controls
// back to manual piloting so that you can fly the ship by hand again.
// If the program just ended here, then that would cause the throttle
// to turn back off again right away and nothing would happen.


