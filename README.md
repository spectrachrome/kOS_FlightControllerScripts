# kOS_FlightControllerScripts

This repository is a personal collection of mine, which contains scripts that can be executed on the [kOS virtual machine](https://ksp-kos.github.io/KOS/) to control virtual spacecraft in Kerbal Space Program.

## [Initiating a Sub-Orbital Burn](#initiating-suborbital-burn)

For now, we'll use the following formula to calculate how much we need to pitch sideways during the ascent, simulating a gravity turn while simultaneously making sure there is no large aerodynamic stress on the vehicle during flight.

<!--
  This Markdown README file features special SVG files which adapt their content's color to the surrounding dark or light theme of the operating system and browser, optimizing contrast. This
  is possible because you can style an SVG graphic by adding CSS in a `foreignObject` XML tag.
-->
<img src="https://space-resources.s3.fr-par.scw.cloud/cycloid_launch_curve.svg" height="64" />

The equation shown here is a transformation of the [cycloid curve equation](https://en.wikipedia.org/wiki/Cycloid#Equations) for the `y` parameter, resolved for the tilt angle `t` (hereby referred to as `θ`) which represents how many degrees our spacecraft will pitch eastwards. The graph traced by this equation looks like this, where the vertical parameter `θ` represents the heading angle and the horizontal paramater `x` represents altitude in kilometers:

<img src="https://space-resources.s3.fr-par.scw.cloud/cycloid_angle_graph.svg" width="100%" />