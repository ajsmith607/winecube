
// wrapper function to track boards, apply color, etc.
module CreateCube(length, width, height) {
    color(WoodColor);
    cube([length, width, height]); 
}


// Create a single Bottle Module 
module CreateBottleModule() {
    for (x = [0 : BottleModuleUnitSize - 1]) {
        xpad = (x == 0) ? 0 : x * UsePartitionThickness;
        transx = (x * BottleUnitDiameter) + xpad;
        for (y = [0 : BottleModuleUnitSize - 1]) {
            ypad = (y == 0) ? 0 : y * UsePartitionThickness;
            transy = (y * BottleUnitDiameter) + ypad;
            if (BottleOrientation == "vertical") {
                translate([transx, transy, 0]) {
                    BottleUnit();
                }
            } else {
                translate([transx,0,transy]) {
                    BottleUnit();
                }
            }
        }
    }
}



// Create a single cross lap joint 
module CreateCrossLapJoint(upperorlower="upper") {
    xrotation = (BottleOrientation == "horizontal") ? 270 : 0 ;
    yrotation = (BottleOrientation == "horizontal" && upperorlower=="lower") ? 270 : 0;
    zrotation = (BottleOrientation == "vertical" && upperorlower=="lower") ? 90 : 0;
    rotate([xrotation, yrotation, zrotation]) {
        difference() {
            // Main cube

            // Depending on orientation, rotation of the cube may move it UsePartitionThickness 
            // away from intended destination, so in the cases where this happens, nudge it to desired location.
            // OpenSCAD variables are immutable and tightly scoped, so a combination of temporary variables
            // and ternary assignments are needed for the correct logic.
            transy_lv = (upperorlower == "lower" && BottleOrientation == "vertical") ? -UsePartitionThickness : 0; 
            transy_uh = (upperorlower == "upper" && BottleOrientation == "horizontal") ? -UsePartitionThickness : 0; 
            transy = transy_lv + transy_uh;
            translate([0, transy, 0]) {
                cube([BottleModuleLength, UsePartitionThickness, BottlePartitionHeight]);
            }
            
            // Notch cubes
            transz = (upperorlower == "lower") ? BottlePartitionHeight/2 : 0 ;
            for (j = [1 : BottleModuleUnitSize]) {
                step = (j * BottleModuleUnitSize) + ((j-1) * UsePartitionThickness);
                translate([step, transy, transz]) {
                    cube([UsePartitionThickness, UsePartitionThickness, BottlePartitionHeight/2]);
                }
            }
        }
    }
}

// Create a single cross lap joint block 
module CreateCrossLapBlock() {
    module assembleseries(upperorlower) {
        for (j = [1 : BottleModuleUnitSize - 1]) {
            step = (j * BottleModuleUnitSize) + ((j-1) * UsePartitionThickness);
            x = (upperorlower=="lower") ? step : 0;
            y = (upperorlower=="upper" && BottleOrientation == "vertical") ? step : 0;
            z = (upperorlower=="upper" && BottleOrientation == "horizontal") ? step : 0;
            translate([x,y,z]) {
                CreateCrossLapJoint(upperorlower); 
            }
        }
    }
    assembleseries("upper");
    assembleseries("lower");
}

// Create a single shelf divider/support
module CreateDivider(depth) { cube([WoodThickness, depth, SidePanelHeight]); }

// Create a single shelf
module CreateShelf() { cube([BottleModuleLength, UseModuleDepth, WoodThickness]); }

// Create a single lip 
module CreateLip() { 
    cube([OverallWidth, WoodThickness, LipHeight]); 
}

// Create outside support panels        
module CreateHorizOutsidePanel() { cube([OverallWidth, OverallDepth, WoodThickness]); }

module CreateVertOutsidePanel() { 
    cube([WoodThickness, OverallDepth - (2 * WoodThickness), SidePanelHeight]); 
}

// Create a single Bottle Module 
module CreateWineModule(rotate, zpad) {
    for (x = [0 : BottleModuleUnitSize - 1]) {
        xpad = (x == 0) ? 0 : x * UsePartitionThickness;
        transx = (x * BottleUnitDiameter) + xpad;
        for (y = [0 : BottleModuleUnitSize - 1]) {
            ypad = (y == 0) ? 0 : y * UsePartitionThickness;
            transy = (y * BottleUnitDiameter) + ypad + BottleUnitDiameter/2;
            if (BottleOrientation == "vertical") {
                translate([transx, transy, -(BottleUnitDiameter/2)]) {
                    CreateWineBottle();
                }
            } else {
                transz = transy - (BottleUnitDiameter/2);
                usetransy = (rotate == 90) ? BottleUnitHeight : zpad; 
                translate([transx, usetransy, transz]) {
                    rotate([rotate, 0, 0]) {
                        CreateWineBottle();
                    }
                }
            }
        }
    }
}
