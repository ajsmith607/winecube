
BottleHeight = 12; 
BottleDiameter = 4;
NeckDiameter = 1; 
NeckHeight = 3;  
TopDiameter = 0.5;
TopHeight = 1;   

BaseTransparency = 1;
NeckTransparency = 0.6;

BaseColor = [122/255,0/255,35/255, BaseTransparency];
NeckColor = [122/255,0/255,35/255, NeckTransparency];

module CreateWineBottle() {
    // Main body of the bottle
    color(BaseColor)
    if (BottleOrientation == "vertical") {
        cylinder(h = BottleHeight - NeckHeight - TopHeight, d = BottleDiameter, center = false);
    } else {
        cylinder(h = BottleHeight - NeckHeight - TopHeight, d = BottleDiameter, center = false);
    }

    // Neck of the bottle
    translate([0, 0, BottleHeight - NeckHeight - TopHeight]) {
        color(NeckColor)
        cylinder(h = NeckHeight, d1 = BottleDiameter, d2 = NeckDiameter, center = false);
    }

    // Top of the bottle (rounded)
    translate([0, 0, BottleHeight - TopHeight]) {
        color(BaseColor)
        cylinder(h = TopHeight, d1 = NeckDiameter, d2 = TopDiameter, center = false);
    }
}

