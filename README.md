# kOS_FlightControllerScripts

This repository is a personal collection of mine, which contains scripts that can be executed on the [kOS virtual machine](https://ksp-kos.github.io/KOS/) to control virtual spacecraft in Kerbal Space Program.

## [Initiating a Sub-Orbital Burn](#initiating-suborbital-burn)

For now, we'll use the following formula to calculate how much we need to pitch sideways during the ascent, simulating a gravity turn while simultaneously making sure there is no large aerodynamic stress on the vehicle during flight.

<!--
  This Markdown README file features special SVG files which adapt their content's color to the surrounding dark or light theme of the operating system and browser, optimizing contrast. This
  is possible because you can style an SVG graphic by adding CSS in a `foreignObject` XML tag.
-->
<img src="https://space-resources.s3.fr-par.scw.cloud/cycloid_launch_curve.svg" height="64" />