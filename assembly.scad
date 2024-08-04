
// Assemble all Bottle Blocks
module AssembleAllBottleUnitBlocks() {
    for (i = [0 : Levels - 1]) {
        transz = ((i+1) * WoodThickness) + (i * UseBlockHeight); 
        for (j = [0 : LevelBlockWidth - 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleBlockMaxSize)); 
            for (k = [0  : LevelBlockDepth - 1]) {
                transy = WoodThickness + (k * (WoodThickness + UseBlockDepth)); 
                translate([transx, transy, transz]) {
                    CreateBottleUnitBlock(); 
                }
            }
        }
    }
}

// Assemble all cross lap blocks
module AssembleAllCrossLapBlocks() {
    // for each level, for each block, place Bottle Block 
    for (i = [0 : Levels - 1]) {
        transz = ((i+1) * WoodThickness) + (i * UseBlockHeight); 
        for (j = [0 : LevelBlockWidth - 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleBlockMaxSize)); 
            for (k = [0  : LevelBlockDepth - 1]) {

                // For horizontally oriented bottles, the back row of AssembleAllCrossLapBlocks
                // may need to be nudged to the center.
                nudge = (BottleOrientation == "horizontal" && LevelBlockDepth > 1) ? UseBlockDepth - BottlePartitionHeight : 0; 
                transy_v = WoodThickness + (k * (WoodThickness + UseBlockDepth)); 
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
    // for each level, for each block, place CreateShelf 
    for (i = [1 : Levels - 1]) {
        transz = i * (WoodThickness + UseBlockHeight); 
        for (j = [0 : LevelBlockWidth- 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleBlockMaxSize)); 
            for (k = [0  : LevelBlockDepth - 1]) {
                transy = WoodThickness + (k * (WoodThickness + UseBlockDepth)); 
                translate([transx, transy, transz]) {
                    CreateShelf();
                }

            }
        }
    }
}

// Assemble all shelves
module AssembleAllLips() {
    // add only to front and back for each level
    for (i = [0 : Levels - 1]) {
        transz = i * (WoodThickness + UseBlockHeight); 

        // back, only if depth is greater than 1
        if (LevelBlockDepth > 1) {
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
        if (LevelBlockDepth > 1) {
            translate([WoodThickness, (OverallDepth/2) - (WoodThickness/2), WoodThickness]) { 
                cube([OverallWidth - (2 * WoodThickness), WoodThickness, OverallHeight - (2 * WoodThickness)]); 
            }     
        }
    }

    if (! includes(flags, "d")) {
        FullDividerDepth = OverallDepth - (WoodThickness * 2);
        HalfDividerDepth = (OverallDepth/2) - (WoodThickness/2) - WoodThickness;
        UseDividerDepth = (LevelBlockDepth == 1) ? FullDividerDepth : HalfDividerDepth;
 
        // rear level dividers 
        for (i = [1 : LevelBlockWidth - 1]) {
            translate([i * (WoodThickness + BottleBlockLength), WoodThickness, WoodThickness ]) {
                CreateDivider(UseDividerDepth);
            }
        }
        
        if (LevelBlockDepth > 1) {
            // front level dividers 
            for (i = [1 : LevelBlockWidth- 1]) {
                translate([i * (WoodThickness + BottleBlockLength), (OverallDepth/2) + (WoodThickness/2), WoodThickness ]) {
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
        if (LevelBlockDepth == 1) {
            translate([0,0,WoodThickness]) { cube([OverallWidth, WoodThickness, SidePanelHeight]); } 
        }
    }
}

module AssembleAllWineBottleBlocks() {
    // for each level, for each block, place Bottle Block 
    for (i = [0 : Levels - 1]) {
        transz = ((i+1) * WoodThickness) + (i * UseBlockHeight) + (BottleDiameter / 2); 
        for (j = [0 : LevelBlockWidth - 1]) {
            transx = WoodThickness + (j * (WoodThickness + BottleBlockLength)) + (BottleDiameter / 2); 
            for (k = [0  : LevelBlockDepth - 1]) {
                transy = WoodThickness + (k * (WoodThickness + BottleBlockLength)) ; 
                translate([transx, transy, transz]) {
                    if (BottleOrientation == "horizontal") {
                        rotate = (k == 0 && LevelBlockDepth == 2) ? 90 : -90; 
                        zpad = (k == 1 && LevelBlockDepth == 2) ? -WoodThickness : 0 ; 
                        //debug(str("depth: ", k, " rotate wine block ", rotate, " zpad: ", zpad));
                        CreateWineBlock(rotate, zpad);
                    } else {
                        CreateWineBlock(0,0);
                    }
                }
            }
        }
    }
}

// Assemble complete wine cube 
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
        AssembleAllWineBottleBlocks();
    }
    
    if (! includes(flags, "u")) {
        debug(str("I SHOULDN'T BE HERE: ", flags));
        AssembleAllBottleUnitBlocks();
    }
}

