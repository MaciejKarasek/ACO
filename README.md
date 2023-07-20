ACO algorithm was developed in the Octave / Matlab environment.  The algorithm selects consecutive cities to visit on the route, based on the probability (pheromone and visibility combined).
=
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MaciejKarasek/ACO)
#### 1. ANTS.m solves simple task for 5 cities based on distances between them and prints working of algorithm by printing the selection of each city en route through the ants based on pheromones and pheromone updates on connections.
ANTS.csv contains distances between cities.
- Shortest founded route: DIST = 16 PATH 1 4 2 3 5 1
- Shortest known route for the task: DIST = 16 PATH 1 4 2 3 5 1

#### 2. ANTS_BURMA14_GRAPH.m solves task BURMA14 based on coordinates of 14 cities. The script creates a connection graph between cities for the best route.
BURMA14.csv contains coortinates of those cities.
- Shortest founded route: DIST = 16 PATH 1 4 2 3 5 1
- Shortest known route for the task: DIST = 16 PATH 1 4 2 3 5 1

#### 3. ANTS_BERLIN52 solves popular task for TSP named 52 cities based on coortinates of that cities. The route chosen by the ants was not the most optimal, however, close, as it differs by less than 2%. 
BERLIN52.csv contains coordinates of those cities.
- Shortest founded route: DIST = 7674.25
- Shortest known route for the task: DIST = 7544.37
