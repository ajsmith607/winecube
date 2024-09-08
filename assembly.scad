
// Assemble all Bottle Modules 
module AssembleAllBottleUnitModules() {
    for (i = [0 : Levels - 1]) {
        transz = ((i+1) * WoodThickness) + (i * UseModuleHeight); 
        for (j = [0 : LevelModuleWidth - 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleModuleMaxSize)); 
            for (k = [0  : LevelModuleDepth - 1]) {
                transy = WoodThickness + (k * (WoodThickness + UseModuleDepth)); 
                translate([transx, transy, transz]) {
                    CreateBottleModule(); 
                }
            }
        }
    }
}

// Assemble all cross lap blocks
module AssembleAllCrossLapBlocks() {
    for (i = [0 : Levels - 1]) {
        transz = ((i+1) * WoodThickness) + (i * UseModuleHeight); 
        for (j = [0 : LevelModuleWidth - 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleModuleMaxSize)); 
            for (k = [0  : LevelModuleDepth - 1]) {

                // For horizontally oriented bottles, the back row of AssembleAllCrossLapBlocks
                // may need to be nudged to the center.
                nudge = (BottleOrientation == "horizontal" && LevelModuleDepth > 1) ? UseModuleDepth - BottlePartitionHeight : 0; 
                transy_v = WoodThickness + (k * (WoodThickness + UseModuleDepth)); 
                transy = (transy_v == WoodThickness) ? transy_v + nudge : transy_v;
                translate([transx, transy, transz]) {
                    CreateCrossLapBlock();
                }

            }
        }
    }
}

// Assemble all shelves
module AssembleAllShelves() {
    // for each level, for each block, place shelf 
    for (i = [1 : Levels - 1]) {
        transz = i * (WoodThickness + UseModuleHeight); 
        for (j = [0 : LevelModuleWidth- 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleModuleMaxSize)); 
            for (k = [0  : LevelModuleDepth - 1]) {
                transy = WoodThickness + (k * (WoodThickness + UseModuleDepth)); 
                translate([transx, transy, transz]) {
                    CreateShelf();
                }

            }
        }
    }
}

// Assemble all shelves
module AssembleAllLips() {
    // add to front and back for each level

    for (i = [0 : Levels - 1]) {

        // account for width of bottom board on first level
        bottombuffer = (i == 0) ?  WoodThickness : 0;

        transz = bottombuffer + i * (WoodThickness + UseModuleHeight); 

        echo ("transz = ",  transz);

        // back, only if depth is greater than 1
        if (LevelModuleDepth > 1) {
            translate([0, 0, transz]) {
                CreateLip();
            }
        }
    
        // front
        translate([0, OverallDepth - WoodThickness, transz]) {
            CreateLip();
        }

    }
}


// Assemble inner support panel structure 
module AssembleInnerStructure() {
    // Vertical center partition
    if (! includes(flags, "c")) {
        if (LevelModuleDepth > 1) {
            translate([WoodThickness, (OverallDepth/2) - (WoodThickness/2), WoodThickness]) { 
                cube([OverallWidth - (2 * WoodThickness), WoodThickness, OverallHeight - (2 * WoodThickness)]); 
            }     
        }
    }

    if (! includes(flags, "d")) {
        FullDividerDepth = OverallDepth - (WoodThickness * 2);
        HalfDividerDepth = (OverallDepth/2) - (WoodThickness/2) - WoodThickness;
        UseDividerDepth = (LevelModuleDepth == 1) ? FullDividerDepth : HalfDividerDepth;
 
        // rear level dividers 
        for (i = [1 : LevelModuleWidth - 1]) {
            translate([i * (WoodThickness + BottleModuleLength), WoodThickness, WoodThickness ]) {
                CreateDivider(UseDividerDepth);
            }
        }
        
        if (LevelModuleDepth > 1) {
            // front level dividers 
            for (i = [1 : LevelModuleWidth- 1]) {
                translate([i * (WoodThickness + BottleModuleLength), (OverallDepth/2) + (WoodThickness/2), WoodThickness ]) {
                    CreateDivider(UseDividerDepth);
                }
            }
        }
    }
}

// Assemble the outer structure
module AssembleOuterStructure() {

    // bottom panel 
    if (! includes(flags, "b")) {
        translate([0, 0, 0]) { CreateHorizOutsidePanel(); }
    }

    // top panel
    if (! includes(flags, "t")) {
        raisetop = (includes(flags, "a")) ? BottleUnitHeight : 0;
        translate([0, 0 - raisetop, OverallHeight - WoodThickness + raisetop]) { CreateHorizOutsidePanel(); }
    }

    // right panel
    if (! includes(flags, "r")) {
        translate([0, WoodThickness, WoodThickness]) { CreateVertOutsidePanel(); }     
    }

    // left panel
    if (! includes(flags, "l")) {
        translate([OverallWidth - WoodThickness, WoodThickness , WoodThickness]) { CreateVertOutsidePanel(); } 
    }

    // back panel
    // added when block depth is 1
    if (! includes(flags, "k")) {
        if (LevelModuleDepth == 1) {
            translate([0,0,WoodThickness]) { cube([OverallWidth, WoodThickness, SidePanelHeight]); } 
        }
    }
}

module AssembleAllWineBottleModules() {
    for (i = [0 : Levels - 1]) {
        transz = ((i+1) * WoodThickness) + (i * UseModuleHeight) + (BottleDiameter / 2); 
        for (j = [0 : LevelModuleWidth - 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleModuleLength)) + (BottleDiameter / 2); 
            for (k = [0  : LevelModuleDepth - 1]) {
                transy = WoodThickness + (k * (WoodThickness + BottleModuleLength)) ; 
                translate([transx, transy, transz]) {
                    if (BottleOrientation == "horizontal") {
                        rotate = (k == 0 && LevelModuleDepth == 2) ? 90 : -90; 
                        zpad = (k == 1 && LevelModuleDepth == 2) ? -WoodThickness : 0 ; 
                        //debug(str("depth: ", k, " rotate wine block ", rotate, " zpad: ", zpad));
                        CreateWineModule(rotate, zpad);
                    } else {
                        CreateWineModule(0,0);
                    }
                }
            }
        }
    }
}

// Assemble complete shelving unit 
module Assemble() {
    AssembleOuterStructure();
    AssembleInnerStructure();
   
    if (! includes(flags, "s")) {
        AssembleAllShelves();
    }

    if (BottleOrientation == "vertical") {
        if (! includes(flags, "i")) {
            AssembleAllLips();
        }
    }

    if (BottleOrientation == "horizontal" && UsePartitionThickness > 0) {
        if (! includes(flags, "p")) {
            AssembleAllCrossLapBlocks();
        }
    }

    if (! includes(flags, "w")) {
        AssembleAllWineBottleModules();
    }
    
    if (! includes(flags, "u")) {
        AssembleAllBottleUnitModules();
    }
}

