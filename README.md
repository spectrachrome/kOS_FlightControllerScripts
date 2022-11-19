# kOS_FlightControllerScripts

This repository is a personal collection of mine, which contains scripts that can be executed on the [kOS virtual machine](https://ksp-kos.github.io/KOS/) to control virtual spacecraft in Kerbal Space Program.

## [Initiating a Sub-Orbital Burn](#initiating-suborbital-burn)

For now, we'll use the following formula to calculate how much we need to pitch sideways during the ascent, roughly simulating a gravity turn and thus making sure the vehicle will not experience large aerodynamic stresses during flight.

<!--
  This Markdown README file features special SVG files which adapt their content's color to the surrounding dark or light theme of the operating system and browser, optimizing contrast. This
  is possible because you can style an SVG graphic by adding CSS in a `foreignObject` XML tag.
-->
<img src="https://space-resources.s3.fr-par.scw.cloud/cycloid_launch_curve.svg" height="64" />

This calculates the ascent angle from the planned apoapsis height and the current altitude. Retrieving the exact starting angle for a real gravity turn is a bit more difficult, so this will do for now.

The equation shown here is the [cycloid curve equation](https://en.wikipedia.org/wiki/Cycloid#Equations) for the `y` parameter, which has been transformed to yield the tilt angle `θ` (referred to as `t` in the article) which represents how many degrees our spacecraft will pitch eastwards during the ascent. The graph traced by this equation looks like this, where the vertical parameter `θ` represents the heading angle in degrees and the horizontal paramater `x` represents altitude in kilometers:

<img src="https://space-resources.s3.fr-par.scw.cloud/cycloid_angle_graph_v2.svg" width="100%" />