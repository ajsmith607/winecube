
// TODO
// - consistency in how "blocks" and "modules" are named 
//  - specify fractional (quarters) blocks to maximize usable space?
//      - ex. 4+2 means 4 whole blocks and two additional bottle units
//  - implement hash like stuctures and methods (nesting is a bit challenging...begin with single level)
//  - JSON metadata output? (Intended for post processing.)
//  - output board list with name/id, length, width, height, number needed (based on unique id) (see Parts->CreateCube for indirection)
//  - different board thickness for inside vs outside structure? (need to update calculations and retest all scenarios) (Or, three thicknesses, 1) Outer shell and center support/divider, 2) "major partitions": shelves and shelf dividers, and 3) "minor partitions": for the bottles within a bottle block in horizontal orientation.)
//  - how to specify hardware, joinery, etc.?
//  - add front and back curtains ?

include <params.scad>  
include <validation.scad>  
include <wine-bottle.scad>  
include <helpers.scad>  
include <model.scad>  
include <parts.scad>  
include <assembly.scad>  
 
// initial structure calculations
UsePartitionThickness = (BottleOrientation == "horizontal") ? BottlePartitionThickness : 0;        // inches

BottleModuleLength = (BottleModuleUnitSize * BottleUnitDiameter) + ((BottleModuleUnitSize - 1) * UsePartitionThickness); 
BottleModuleMaxSize = (BottleModuleLength > BottleUnitHeight) ? BottleModuleLength : BottleUnitHeight;
UseModuleHeight = (BottleOrientation == "horizontal") ? BottleModuleMaxSize: BottleUnitHeight; 
UseModuleDepth= (BottleOrientation == "horizontal") ? BottleUnitHeight : BottleModuleMaxSize; 

// Calculate the overall dimensions
OverallWidth = (LevelModuleWidth* BottleModuleMaxSize) + ((LevelModuleWidth+ 1) * WoodThickness); // plywood for outer sides and middle panel
OverallDepth = (LevelModuleDepth* UseModuleDepth) + ((LevelModuleDepth+ 1) * WoodThickness); // plywood for middle panel, slats on front and back 
OverallHeight = (Levels * UseModuleHeight) + ((Levels + 1) * WoodThickness); // plywood for top, bottom, and each CreateShelf (the bottom is a CreateShelf)

// other calculations
SidePanelHeight = OverallHeight - (2 * WoodThickness);

// Misc
TotalBottleCapacity = Levels * LevelModuleWidth * LevelModuleDepth * pow(BottleModuleUnitSize, 2);
EstimatedLoad = TotalBottleCapacity * BottleUnitWeight;

orient = (BottleOrientation == "vertical") ? "V" : "H";
ModelNum = str(orient, TotalBottleCapacity);
OverallDims = str(OverallHeight, "x", OverallWidth, "x", OverallDepth);
ModelInfo= str(ModelNum, "-", OverallDims, "-", LevelModuleDepth, Levels, LevelModuleWidth, "-", flags);
//force output of ModelInfo
echo(ModelInfo);

Assemble();
//BottleUnit();
//CreateBottleModule(); 


