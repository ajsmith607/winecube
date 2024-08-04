
// TODO
//  - specify fractional (quarters) blocks to maximize usable space?
//  - implement hash like stuctures and methods (nesting is a bit challenging...begin with single level)
//  - JSON metadata output? (Intended for post processing.)
//  - output board list with name/id, length, width, height, number needed (based on unique id) (see Parts->CreateCube for indirection)
//  - different board thickness for inside vs outside structure? (need to update calculations and retest all scenarios) (Or, three thicknesses, 1) Outer shell and center support/divider, 2) "major partitions": shelves and shelf dividers, and 3) "minor partitions": for the bottles within a bottle block in horizontal orientation.)
//  - how to represent screws/holes, etc.?
//  - add front and back curtains

include <params.scad>  
include <helpers.scad>  
include <validation.scad>  
include <wine-bottle.scad>  
include <model.scad>  
include <parts.scad>  
include <assembly.scad>  
 
WoodColor = "brown";

// initial structure calculations
UsePartitionThickness = (BottleOrientation == "horizontal") ? BottlePartitionThickness : 0;        // inches

BottleBlockLength = (BottleBlockUnitSize * BottleUnitDiameter) + ((BottleBlockUnitSize - 1) * UsePartitionThickness); 
BottleBlockMaxSize = (BottleBlockLength > BottleUnitHeight) ? BottleBlockLength : BottleUnitHeight;
UseBlockHeight = (BottleOrientation == "horizontal") ? BottleBlockMaxSize: BottleUnitHeight; 
UseBlockDepth= (BottleOrientation == "horizontal") ? BottleUnitHeight : BottleBlockMaxSize; 

// Calculate the overall dimensions
OverallWidth = (LevelBlockWidth* BottleBlockMaxSize) + ((LevelBlockWidth+ 1) * WoodThickness); // plywood for outer sides and middle panel
OverallDepth = (LevelBlockDepth* UseBlockDepth) + ((LevelBlockDepth+ 1) * WoodThickness); // plywood for middle panel, slats on front and back 
OverallHeight = (Levels * UseBlockHeight) + ((Levels + 1) * WoodThickness); // plywood for top, bottom, and each CreateShelf (the bottom is a CreateShelf)

// other calculations
SidePanelHeight = OverallHeight - (2 * WoodThickness);

// Misc
TotalBottleCapacity = Levels * LevelBlockWidth * LevelBlockDepth * pow(BottleBlockUnitSize, 2);
EstimatedLoad = TotalBottleCapacity * BottleUnitWeight;

orient = (BottleOrientation == "vertical") ? "V" : "H";
ModelNum = str(orient, TotalBottleCapacity);
OverallDims = str(OverallHeight, "x", OverallWidth, "x", OverallDepth);
ModelInfo= str(ModelNum, "-", OverallDims, "-", EstimatedLoad, "-", flags);
//force output of ModelInfo
echo(ModelInfo);

Assemble();



