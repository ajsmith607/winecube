
// Parameters for the wine bottle unit space model
BottleUnitDiameter= 4;              // inches
BottleUnitHeight = 16;              // inches
BottleUnitWeight = 4;               // pounds
BottleModuleUnitSize = 4;           // a standard Bottle Module is 4x4 Bottle Units

winecolor = [128/255, 0/255, 32/255, 0.16];

// Create a single Bottle Unit 
module BottleUnit() {
    rotation = (BottleOrientation == "horizontal") ? -90 : 0; 
    nudge = (BottleOrientation == "horizontal") ? -BottleUnitDiameter : 0; 
    rotate([rotation,0,0]) {
        translate([0, nudge, 0]) {
            color(winecolor) 
            cube([BottleUnitDiameter, BottleUnitDiameter, BottleUnitHeight]);
        }
    }
}

