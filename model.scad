
// Parameters for the wine bottle unit space model
BottleUnitDiameter= 4;              // inches
BottleUnitHeight = 16;              // inches
BottleUnitWeight = 4;               // pounds
BottleBlockUnitSize = 4;            // a standard Bottle Block is 4x4 Bottle Units

// Create a single Bottle Unit 
module BottleUnit() {
    rotation = (BottleOrientation == "horizontal") ? -90 : 0; 
    nudge = (BottleOrientation == "horizontal") ? -BottleUnitDiameter : 0; 
    rotate([rotation,0,0]) {
        translate([0, nudge, 0]) {
            color([0,0,1, 0.05])
            cube([BottleUnitDiameter, BottleUnitDiameter, BottleUnitHeight]);
        }
    }
}


