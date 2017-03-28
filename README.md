# Developing Data Products Final project
## Project on Montecarlo method using shiny app in R

### Introduction
The purpose of this app is to allow users to discover in a intuitive way the principles of MonteCarlo method. This method relies on repeated random sampling to obtain numerical results (often a deterministic problem). Further reading

In this case, the user will be able to determine the area of a circle. The areas are calculated in two different ways (1) Geometrical: using the formula of the circle area, (2) Monte Carlo: counting the number of points that landed inside the circle and dividing it by the total number of points drawn and then multipling it by the area of the experimentation surface (100x100 units^2).

Then, the associated error of the Monte Carlo method is pointed out using two methods. (a)Empirically: where the percentage of the difference of the two areas is calculated and (b)Theoretically: Where the formula 1/sqrt(n) from the Central Limit Theorem is used being n the number of random points drawn

### Side Bar interaction buttons
* Number of random points
Slide the point through the bar to determine the number of point to be generated in the experimentation area from 10 to 1000 points.

* Radius of the circle
Slide the point through the bar to determine the radius of the circle in the experimentation area from 10 to 50 units.

* Change the seed for random number generation
Use the arrows or introduce by hand the number used for the seed to generate pseudo-random points. Values accepted go from 1 to 9999.

### Tabs: Experimentation and Asymptotics
The Experimentation tab allows you to visually comprehend through a plot the results from the different settings of the two slider bars and the change of the seed for the random generation algorithm. Take a look at how the error values differ depending on the radius of the circle and the number of generated points. Furthermore, at the Asymptotics tab you may find that the bigger the circle, the more accurate the MonteCarlo approximation is.
