// The Kwawu 2.0 prosthetic Arm - Thermoform Version
// By Jacqun Buchanan
// Parameteric 3-d printable prosthetic arm
//
// This design is licensed under the Creative Commons - Attribution - Share Alike license.

// The ISO thread code is by Trevor Moseley

// Preview Each Part
part = "Cuff"; // [ Cuff:Cuff, Arm1:Arm1, Arm2:Arm2, Arm3:Arm3, Arm4:Arm4, Palm:Palm,PalmTop:PalmTop, PalmBolt:PalmBolt, WristArmAttach:WristArmAttach, WristBolt:WristBolt, ElbowBolt:ElbowBolt, Tensioner:Tensioner, IndexFingerEnd:IndexFingerEnd, IndexFingerPhalanx:IndexFingerPhalanx, MiddleFingerEnd:MiddleFingerEnd, MiddleFingerPhalanx:MiddleFingerPhalanx, PinkyFingerEnd:PinkyFingerEnd, PinkyFingerPhalanx:PinkyFingerPhalanx, RingFingerEnd:RingFingerEnd, RingFingerPhalanx:RingFingerPhalanx, ThumbEnd:ThumbEnd, ThumbPhalanx:ThumbPhalanx, WhippleTreePrimary:WhippleTreePrimary, WhippleTreeSecondary:WhippleTreeSecondary, LatchSlider:LatchSlider, LatchPin:LatchPin, LatchTeeth:LatchTeeth, PencilHolderCover:PencilHolderCover, WristCompressionBushing:WristCompressionBushing, Hinge4Knuckles:Hinge4Knuckles, HingeIndexFinger:HingeIndexFinger, HingeMiddleFinger:HingeMiddleFinger, HingePinkyFinger:HingePinkyFinger, HingeRingFinger:HingeRingFinger, HingeThumb:HingeThumb, HingeThumbKnuckle:HingeThumbKnuckle, LatchHinge:LatchHinge, Thermoform1:Thermoform1, Thermoform2:Thermoform2, Thermoform3:Thermoform3, Cover1:Cover1, Cover2:Cover2, Cover3:Cover3, Cover4:Cover4 ]

// Choose Left or Right Hand
LeftRight = "Left"; // [Left,Right]
// Across all four knuckles (mm)
HandWidth = 93; //[50:186]
// Wrist to elbow crease (mm)
ArmLength = 282; //[141: 564]
// Circumference of Forearm just below elbow crease (mm)
ForearmCircumference = 271; //[135: 542]
// - Circumference of Bicep (mm)
BicepCircumference = 294; //[147: 600]
// Padding Thickness -inside forearm and cuff (mm)
PaddingThickness = 2; //[0: 10]
// How many pieces to divide the arm into 
ArmPieces = 2; //[1, 2, 4]
// How many pieces to divide the cover into 
CoverPieces = 2; //[1, 2, 4]
// ISO metric bolt holding palm together (mm) 
PalmBoltDiameter = 6;//[4, 6, 8]
// Diameter of pin holding cover on (mm)
CoverPinDiameter = 8;//[0, 4, 6, 8, 10]
// ISO metric bolt holding cuff and arm together (mm)
ElbowBoltDiameter = 8; //[4, 6, 8, 10, 12, 14]
// ISO metric bolt for adjusting tensioner (mm)
TensionerBoltDiameter = 3; //[2, 3, 4]
// Include Grip Latch
GripLatch = "Yes"; // [Yes,No]
// Include Pencil Holder
PencilHolder = "No"; // [Yes,No]

/* [Hidden] */

// This is an amount added to the pencil cover length. 
// When this is zero the pencil cover is as tight as possible.
// Make it larger to fit around larger/thicker pencils
PencilCoverAddedLength = 4.0;

PI =  3.141592653589793238;
HandVersion = "V2.2";
ArmScale = ArmLength/299;
HandScale = HandWidth / 93;
ForearmCircumferenceWPadding = ((ForearmCircumference/PI) + 2*PaddingThickness)*PI;
ForeArmCircumferenceScale = ForearmCircumferenceWPadding/271;
BicepCircumferenceWPadding = ((BicepCircumference/PI) + 2*PaddingThickness)*PI;
CuffScale = BicepCircumferenceWPadding/294;

WristBoltDia = 25;
$fn=30;

print_part();


module print_part( ) {
    
    if(part == "ElbowBolt") {
        // ( dia,hi, headhi, headDiameter, hexDiameter)
        make_bolt(ElbowBoltDiameter, ArmScale * 6 + CuffScale * 10, ElbowBoltDiameter/2, ElbowBoltDiameter *3);
    }
    
    if (part == "Tensioner") {
        MakeTensioner();
    }
    
    
    if (part == "Cuff") {
        if (LeftRight == "Left") {
            mirror([0,1,0]) MakeCuff();
        } else {
            MakeCuff();
        }
    }
    
    if(part == "WristArmAttach") { 
        if (LeftRight == "Left") {
            mirror([1,0,0]) makeWristArmAttach();
        } else {
           makeWristArmAttach();
        } 
    }
    
    if (part == "Arm1") {
        // rotate for better print orientation
        rotate([90,0,0])
        if (LeftRight == "Left") {
            mirror([1,0,0]) MakeArm(1);
        } else {
            MakeArm(1);
        }
    } 
    
    if (part == "Arm2") {
        
        if(ArmPieces > 1 )
        {
            // rotate for better print orientation
            rotate([90,0,0])
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeArm(2);
            } else {
                MakeArm(2);
            }
        }
    } 
    
    if (part == "Arm3") {
        
        if(ArmPieces > 2 )
        {
            // rotate for better print orientation
            rotate([90,0,0])
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeArm(3);
            } else {
                MakeArm(3);
            }
        }
    } 
    
    if (part == "Arm4") {
        
        if(ArmPieces > 2 )
        {
            // rotate for better print orientation
            rotate([90,0,0])
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeArm(4);
            } else {
                MakeArm(4);
            }
        }
    } 
    
    if (part == "Cover1") {
        
        // rotate for better print orientation
        rotate([90,0,0]) 
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeCover1();
            } else {
                MakeCover1();
            }
    }
    
   if (part == "Cover2") {
        
        // rotate for better print orientation
        rotate([90,0,0]) 
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeCover2();
            } else {
                MakeCover2();
            }
    }
    
    if (part == "Cover3") {
        
        if(CoverPieces ==4) {
            // rotate for better print orientation
            rotate([90,0,0]) 
                if (LeftRight == "Left") {
                    mirror([1,0,0]) Cover3of4();
                } else {
                    Cover3of4();
                }
        }
    }
    
    if (part == "Cover4") {
        
        if(CoverPieces ==4) {
            // rotate for better print orientation
            rotate([90,0,0]) 
                if (LeftRight == "Left") {
                    mirror([1,0,0]) Cover4of4();
                } else {
                    Cover4of4();
                }
        }
    }
    
    if (part == "Thermoform1") {
        // rotate for better print orientation
        rotate([0,180,0]) 
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeThermoform1();
            } else {
                MakeThermoform1();
            }
    } 
    
    if (part == "Thermoform2") {
        if (LeftRight == "Left") {
            mirror([1,0,0]) Thermoform2();
        } else {
            Thermoform2();
        }
    } 
    
    if (part == "Thermoform3") {
      
        if (LeftRight == "Left") {
            mirror([1,0,0]) MakeThermoform3();
        } else {
            MakeThermoform3();
        }
    } 
    
    if (part == "Palm") {
        if (LeftRight == "Left") {
            mirror([1,0,0]) MakePalm();
        } else {
            MakePalm();
        }
    } 
    
    if (part == "PalmTop") {
        if (LeftRight == "Left") {
            mirror([1,0,0]) MakePalmTop();
        } else {
            MakePalmTop();
        }
    }
    
    if(part == "IndexFingerEnd") {  
        if (LeftRight == "Left") {
            mirror([1,0,0]) IndexFingerEnd();
           } else {
            IndexFingerEnd();
        }
    }
    
    if(part == "IndexFingerPhalanx") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) IndexFingerPhalanx();
           } else {
            IndexFingerPhalanx();
        }
    }
            
    if(part == "MiddleFingerEnd") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) MiddleFingerEnd();
           } else {
            MiddleFingerEnd();
        }
    }
                
    if(part == "MiddleFingerPhalanx") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) MiddleFingerPhalanx();
           } else {
            MiddleFingerPhalanx();
        }
    }
                    
    if(part == "PinkyFingerEnd") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) PinkyFingerEnd();
           } else {
            PinkyFingerEnd();
        }
    }
    
    if(part == "PinkyFingerPhalanx") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) PinkyFingerPhalanx();
           } else {
            PinkyFingerPhalanx();
        }
    }
    
    if(part == "RingFingerEnd") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) RingFingerEnd();
           } else {
            RingFingerEnd();
        }
    }
    
    if(part == "RingFingerPhalanx") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) RingFingerPhalanx();
           } else {
            RingFingerPhalanx();
        }
    }
    
    if(part == "ThumbEnd") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) ThumbEnd();
           } else {
            ThumbEnd();
        }
    }
    
    if(part == "ThumbPhalanx") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) ThumbPhalanx();
           } else {
            ThumbPhalanx();
        }
    }
    
    if(part == "WhippleTreePrimary") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) WhippleTreePrimary();
           } else {
            WhippleTreePrimary();
        }
    }
    
    if(part == "WhippleTreeSecondary") { 
         if (LeftRight == "Left") {
            mirror([1,0,0]) WhippleTreeSecondary();
           } else {
            WhippleTreeSecondary();
        }
    }
    
       if(part == "LatchSlider") { 
           if(GripLatch == "Yes") {
             if (LeftRight == "Left") {
                mirror([1,0,0]) LatchSlider();
               } else {
                LatchSlider();
            }
        }
    }
    
       if(part == "LatchPin") { 
           if(GripLatch == "Yes") {
             if (LeftRight == "Left") {
                mirror([1,0,0]) LatchPin();
               } else {
                LatchPin();
            }
        }
    }
    
       if(part == "LatchTeeth") { 
          if(GripLatch == "Yes") {
             if (LeftRight == "Left") {
                mirror([1,0,0]) LatchTeeth();
               } else {
                LatchTeeth();
            }
        }
    }
    
    if(part == "PalmBolt") { make_bolt(PalmBoltDiameter, HandScale * 23, PalmBoltDiameter, PalmBoltDiameter  + PalmBoltDiameter/2); }
    
        
    if(part == "WristBolt") { 
        // rotate for better print orientation
        rotate([0,90,0]) 
        MakeWristBolt();
    }
    
    if(part == "Hinge4Knuckles") { scale([HandScale,HandScale,HandScale]) cube([20, 2.5, 6.25]); }
    
    if(part == "HingeIndexFinger") { scale([HandScale,HandScale,HandScale]) cube([20, 2.5, 6.25]); }
    
    if(part == "HingeMiddleFinger") { scale([HandScale,HandScale,HandScale]) cube([18, 2.5, 6.25]); }
    
    if(part == "HingePinkyFinger") {  scale([HandScale,HandScale,HandScale]) cube([15.5, 2.5, 6.25]); }
    
    if(part == "HingeRingFinger") { scale([HandScale,HandScale,HandScale]) cube([18, 2.5, 6.25]); }
    
    if(part == "HingeThumb") { scale([HandScale,HandScale,HandScale]) cube([21, 2.5, 6.25]); }
    
    if(part == "HingeThumbKnuckle") { scale([HandScale,HandScale,HandScale]) cube([31, 2.5, 6.25]); }
    
    if(part == "LatchHinge") { scale([ArmScale,ArmScale,ArmScale]) cube([12, 2.5, 6.25]); }
    
    if(part == "PencilHolderCover")
    {
        PencilHolderCover();
    }
    
     if(part == "WristCompressionBushing")
    {
        MakeWristCompressionBushing();
    }
    
}

module MakeWristCompressionBushing() {
    
    WristDiameter = 53.6 * HandScale;
    CenterOfWasher = (WristDiameter + 25.5)/2;
    
    // center ring that actually compresses
    difference() {
        translate([0, 0, 2]) cylinder(d=CenterOfWasher+0.5, h = 4, center=true, $fn=200);
        translate([0, 0, 1.75]) cylinder(d=CenterOfWasher-0.5, h = 5, center=true, $fn=200);

        union(){
            for ( i = [0 : 20 : 340] ) {            
                rotate(i){
                    cube([CenterOfWasher+1,1, 5]);
                }
            }
        }
     }
   
     // outer ring that covers the gap.
    difference () {
        translate([0, 0, 3])cylinder(d=WristDiameter + 1.5, h = 6, center=true, $fn=200);
        translate([0, 0, 2.75])cylinder(d=WristDiameter + 0.5, h = 7, center=true, $fn=200);
    }
    
    // flat end of the washer
    difference () {
        translate([0, 0, 0.3])cylinder(d=WristDiameter + 1.5, h = 0.6, center=true, $fn=200);
        translate([0, 0, 0.25])cylinder(d=25.5, h = 1.0, center=true, $fn=200);
    }
    
}

module PencilHolderCover() {
    
    ShortestPencilCover = 27*HandScale;
    
    cube([ShortestPencilCover + PencilCoverAddedLength, 1.5*HandScale, 12*HandScale]);
    
    translate([0, -0.25 * HandScale, 6 * HandScale]) cylinder(d=3.5*HandScale, h = 12*HandScale, center=true, $fn=30);
    
    translate([ShortestPencilCover + PencilCoverAddedLength, -0.25 * HandScale, 6 * HandScale]) cylinder(d=3.5*HandScale, h = 12*HandScale, center=true, $fn=30);
    }

module MakeTensioner() {
    
    //rotate for better print orientation
rotate([-90,0,0]) 
    
    difference() {
        Tensioner();
        
        //Cut a hole for tensioner bolts
        translate([CuffScale  * 122.79, CuffScale  * -108.574, CuffScale  * 4.5]) rotate([0,90,0])  cylinder(d=TensionerBoltDiameter + 0.5, h = CuffScale  * 60, center=true, $fn=30);
        
        //Cut a hole for encapsulated bolt
        translate([CuffScale  * 122.79 - 3*TensionerBoltDiameter, CuffScale  * -108.574 - 3*TensionerBoltDiameter/2, CuffScale  * 4.5]) rotate([90,0,90]) cube([TensionerBoltDiameter * 4, TensionerBoltDiameter * 1.82, TensionerBoltDiameter], center = true);
        
        translate([CuffScale  * 122.79 - 3*TensionerBoltDiameter, CuffScale  * -108.574, CuffScale  * 4.5]) rotate([90,0,90])  cylinder(d=TensionerBoltDiameter * 2.1, h = TensionerBoltDiameter, center=true, $fn=6);
    }
    
    
    
}

module MakeCuff() {
    
    difference() {
        Cuff();
        
        //Cut a holes for elbow bolts
        translate([CuffScale  * 58.65, CuffScale  * -157, 0 ]) cylinder(d=ElbowBoltDiameter + 1, h = CuffScale  * 150, center=true, $fn=30);
        translate([CuffScale  * 58.65, CuffScale  * -303.63, 0 ]) cylinder(d=ElbowBoltDiameter + 1, h = CuffScale  * 150, center=true, $fn=30);
        
        //Cut a hole for tensioner bolts
        translate([CuffScale  * 172.85, CuffScale  * -293.798, CuffScale  * 6.25 ]) rotate([0,90,0])  cylinder(d=TensionerBoltDiameter + 0.5, h = CuffScale  * 50, center=true, $fn=30);
    }
    
   
}


module MakeWristBolt() {
 
    hi = 10.00 * HandScale + 15 * ArmScale;
    
    difference() {
        
        union() {
            // basic cyliner of bolt
            thread_out_centre(WristBoltDia,hi);
            
            // round the ends to not wear the thread
            translate([0, 0, 2 ]) rotate_extrude(convexity = 10) translate([WristBoltDia/4, 0, 0]) circle(r = WristBoltDia/5.5, $fn = 100);
            translate([0, 0, hi-2 ]) rotate_extrude(convexity = 10) translate([WristBoltDia/4, 0, 0]) circle(r = WristBoltDia/5.5, $fn = 100);
            
            difference(){
                
                //make threads
                translate([0, 0, -5 ]) thread_out(WristBoltDia,hi+10);
               
                //Cut threads evenly at bolt ends
                translate([0, 0, -5 ]) cylinder(d = WristBoltDia + 10, h = 10, center=true, $fn=30);
                translate([0, 0, hi+5 ]) cylinder(d = WristBoltDia + 10, h = 10, center=true, $fn=30);
                
            }
        }
      
        //Cut flat top and bottom to make printable
        translate([9*WristBoltDia /10, 0, hi/2 -5]) cube([ WristBoltDia + 1, WristBoltDia + 1, hi+15], center= true);
        //translate([-9*WristBoltDia /10, 0, hi/2 -5]) cube([ WristBoltDia + 1, WristBoltDia + 1, hi+15], center= true);
        
        //Cut a hole down middle for string
        translate([0, 0, hi/2 +5 ]) cylinder(d = WristBoltDia/5.5, h = hi +15, center=true, $fn=30);
        
    }
    
}

module MakeArm(PieceNumber) {
    
    difference(){
        
        if(ArmPieces == 1) {
            Arm1of1();
        } else {
            if(ArmPieces == 2) {
                    
                if(PieceNumber == 1)
                    Arm1of2();
                else 
                    Arm2of2();
            
            } else {
                if(PieceNumber == 1)
                    Arm1of4();
                else {
                    if(PieceNumber == 2)
                        Arm2of4();
                    else {
                        if(PieceNumber == 3)
                            Arm3of4();
                        else
                             Arm4of4();
                    }
                }
            }
        }
              
         // Make hole for Elbow threads
        translate([ForeArmCircumferenceScale  * 60.36, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) cylinder(d=ElbowBoltDiameter, h=ArmScale * 200,center=true, $fn=20);
        
        translate([ForeArmCircumferenceScale  * -74.64, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) cylinder(d=ElbowBoltDiameter, h=ArmScale * 200,center=true, $fn=20);
            
        if(GripLatch == "Yes")
          {
              //Make hole for grip latch hinge
              translate([33.95* ForeArmCircumferenceScale, 38.83 * ArmScale, -(242.76* ArmScale)]) rotate([-90,0,0]) LatchHole();
          }
          
        if(PieceNumber ==1)  {
            //make guide holes
            translate([ForeArmCircumferenceScale  * 47.228 - 2 *HandScale, ArmScale  * 27.319, ArmScale * -30.326 + HandScale * -15 ]) 
            cube([HandScale  * 4, HandScale  * 20, HandScale *7]);
            
            translate([ForeArmCircumferenceScale  * 47.228 - (40.186125+5) *HandScale , ArmScale  * 27.319,  ArmScale * -30.326 + HandScale * -15]) 
            cube([HandScale  * 10, HandScale  * 20, HandScale *7]);
        
            translate([ForeArmCircumferenceScale  * 47.228 - (2*40.186125+2) *HandScale, ArmScale  * 27.319,  ArmScale * -30.326 + HandScale * -15 ]) 
            cube([HandScale  * 4, HandScale  * 20, HandScale *7]);
        
            translate([ForeArmCircumferenceScale  * 47.228 - (3*40.186125 +2) *HandScale, ArmScale  * 27.319, ArmScale * -30.326 + HandScale * -15]) 
            cube([HandScale  * 4, HandScale  * 20, HandScale *7]);
            
            //cut the arm to fit around the wrist
            translate([ForeArmCircumferenceScale  * 62.989 - 160.7445 *HandScale -  200, ArmScale  * 27.319, HandScale  * -42.6 -50]) 
            cube([ 200, 20, 200]);
            
        }
        
    }
    
   
    if(PieceNumber ==1 && CoverPinDiameter > 0) {
    
        // Make pins for cover
        translate([ForeArmCircumferenceScale  * 27.228, ArmScale  * 37.319 + ArmScale  * 10, ArmScale  * -39.35 ]) 
        rotate([90,0,0])  
        cylinder(d=CoverPinDiameter + 0.5, h = ArmScale  * 12.5, center=false, $fn=30);
    
        translate([ForeArmCircumferenceScale  * 27.228 - 80.37225*HandScale, ArmScale  * 37.319 + ArmScale  * 10, ArmScale  * -39.35 ]) 
        rotate([90,0,0]) 
        cylinder(d=CoverPinDiameter + 0.5, h = ArmScale  * 10, center=false, $fn=30);
        
    }   
    
    
    if((ArmPieces == 4 && PieceNumber == 3) || (ArmPieces == 2 && PieceNumber == 2) || ArmPieces == 1) {
       
        difference() {

            //Add inner threads for elbow bolt holder
            translate([ForeArmCircumferenceScale  * -74.64, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) translate([0, 0, -2 * ArmScale  ])thread_in(ElbowBoltDiameter, ArmScale * 10);
                    
            translate([ForeArmCircumferenceScale  * -74.64, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) translate([0, 0, ArmScale * -5]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmScale * 10,center=true, $fn=20);
           
           translate([ForeArmCircumferenceScale  * -74.64, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) translate([0, 0, ArmScale * 11]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmScale * 10,center=true, $fn=20);
        }
    }
          
   if((ArmPieces == 4 && PieceNumber == 4) || (ArmPieces == 2 && PieceNumber == 2) || ArmPieces == 1) {
       
       difference() {
            //Add inner threads for elbow bolt holder
            translate([ForeArmCircumferenceScale  * 60.36, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) translate([0, 0, -2 * ArmScale  ])thread_in(ElbowBoltDiameter, ArmScale * 10);
                    
            translate([ForeArmCircumferenceScale  * 60.36, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) translate([0, 0, ArmScale * -5]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmScale * 10,center=true, $fn=20);
           
           translate([ForeArmCircumferenceScale  * 60.36, ArmScale  * 40.819, ArmScale  * -324.376 ]) rotate([90,0,0]) translate([0, 0, ArmScale * 11]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmScale * 10,center=true, $fn=20);
       }

        if(GripLatch == "Yes")
        {
            translate([33.95* ForeArmCircumferenceScale, 38.83 * ArmScale, -(242.76* ArmScale)]) rotate([-90,0,0])  LatchBase();
        }
    }
    
    
}

module MakeCover1() {
    difference() {
        
        if(CoverPieces ==1)
            Cover1of1();
        if(CoverPieces ==2)
            Cover1of2();
        if(CoverPieces ==4)
            Cover1of4();
        
         //Cut a hole for piovoting bolts
        translate([ForeArmCircumferenceScale  * -235.07, ArmScale  * 0, ArmScale  * -44.8 ]) rotate([90,0,0])  cylinder(d=CoverPinDiameter + 0.5, h = ArmScale  * 50, center=true, $fn=30);
    
        translate([ForeArmCircumferenceScale  * -342.255, ArmScale  * 0, ArmScale  * -44.8 ]) rotate([90,0,0])  cylinder(d=CoverPinDiameter + 0.5, h = ArmScale  * 50, center=true, $fn=30);
         
    }
    

}

module MakeCover2() {

if(CoverPieces !=1)
{

    difference () {
        if(CoverPieces ==2)
            Cover2of2();
        if(CoverPieces ==4)
            Cover2of4();
    
        //Cut a hole for pivoting bolts
        translate([ForeArmCircumferenceScale  * -235.07, ArmScale  * 0, ArmScale  * -44.8 ]) rotate([90,0,0])  cylinder(d=CoverPinDiameter + 0.5, h = ArmScale  * 50, center=true, $fn=30);
         
    }
}
    
}

module makeWristArmAttach(){
     difference(){
        WristArmAttach();

        // cut large hole for wrist bolt 
        // the -0.05 on bolt diamter is to make sure threads attach to walls
        translate([2.513 * HandScale, 14.753 * HandScale, -(21.5* ArmScale) + (26* ArmScale)/2 ]) 
        cylinder(d = WristBoltDia - 0.05, h = 60.00 * HandScale + 50 * ArmScale, center=true, $fn=30);
/*        
          //cut a slot for the compression ring 
        translate([2.513 * HandScale, 14.753 * HandScale, -(22.5 * HandScale) -3 ]) 
        cylinder(d = WristBoltDia+8, h = 4, center=false, $fn=30);
*/
    }
    
    difference() {
            
         //Add inner threads for wrist bolt holder
        translate([2.513 * HandScale, 14.753 * HandScale, -(20 * HandScale + 40 * HandScale) +(-3* HandScale) ]) 
        thread_in(WristBoltDia, 23 * HandScale + 40 * HandScale);
  /*        
        // truncate threads length to hand end
        translate([2.513 * HandScale - 100, 14.753 * HandScale - 100, -(22.5* HandScale + 3)])
        cube(200);
*/
        
        translate([2.513 * HandScale - 100, 14.753 * HandScale - 100, -(22.5* HandScale)])
        cube(200);
            
        // truncate threads length to wrist end
        translate([2.513 * HandScale - 100, 14.753 * HandScale - 100, -200-(37.5* HandScale)+0.5])
        cube(200);
    }
    
}

module MakePalm() {
    
    difference(){
        Palm();
        // cut  first hole for bolt to hold palm together
        translate([HandScale * 12,0, HandScale * 84.35]) rotate([90,0,7]) cylinder(d=PalmBoltDiameter + 0.5,  h=100,center=true, $fn=20);
        translate([HandScale * 12, 0, HandScale * 84.35]) rotate([90,0,7]) translate([0, 0, -PalmBoltDiameter + 2 * HandScale])  cylinder(d=PalmBoltDiameter  + PalmBoltDiameter/2 + 1, h=100,center=false, $fn=20);
        
        // cut  second hole for bolt to hold palm together
        translate([HandScale * -32.767,0,HandScale * 76.472]) rotate([90,0,7]) cylinder(d=PalmBoltDiameter + 0.5, h=100,center=true, $fn=20);
        translate([HandScale * -32.767, 0,HandScale * 76.472]) rotate([90,0,7]) translate([0, 0, -PalmBoltDiameter + 2 * HandScale]) cylinder(d=PalmBoltDiameter + PalmBoltDiameter/2 + 1 + 0.5, h=100,center=false, $fn=20);
 
  
        // cut large hole for wrist bolt 
        // the -0.05 on bolt diamter is to make sure threads attach to walls
        translate([2.513 * HandScale, 14.753 * HandScale, -(21.5* HandScale) + (-2* HandScale)/2 ]) 
        cylinder(d = WristBoltDia - 0.05, h = 27.00 * HandScale, center=true, $fn=30);
        
        // cut small hole for wrist bolt 
        translate([2.513 * HandScale, 14.753 * HandScale, -(21.5* HandScale) + (36* HandScale)/2 ]) 
        cylinder(d = WristBoltDia - 4, h = 36.00 * HandScale, center=true, $fn=30);
        
  /*      
        // champfer wrist base
        translate([2.513 * HandScale, 14.753 * HandScale, -(21.5 * HandScale) +1]) 
        cylinder(d = WristBoltDia+6, h = 4.00 , center=true, $fn=30);
        
        // champfer wrist base
        translate([2.513 * HandScale, 14.753 * HandScale, -(23 * HandScale) +2]) 
        cylinder(d1 = WristBoltDia+6, d2 = WristBoltDia, h = 4.00 , center=true, $fn=30);
    
     */   
        // If the pencil Holder is seelcted then cut it out
        if(PencilHolder =="Yes")
        {
            PencilHolderTool();
        }
    }
    

    difference(){
        
        //Add inner threads for wrist bolt holder
        translate([2.513 * HandScale, 14.753 * HandScale, -(20 * HandScale + 40 * ArmScale) +(-3* HandScale) ])  
        thread_in(WristBoltDia, 23 * HandScale + 40 * ArmScale);
        
        // truncate threads length to inside palm
        translate([2.513 * HandScale - 100, 14.753 * HandScale - 100, (-6 * HandScale)-0.5])
        cube(200);
       
        /*
        // truncate threads length to wrist end
        translate([2.513 * HandScale - 100, 14.753 * HandScale - 100, -197-(21.5* HandScale) ]) 
        cube(200);
        */
        
        // truncate threads length to wrist end
        translate([2.513 * HandScale - 100, 14.753 * HandScale - 100, -200-(21.5* HandScale) ]) 
        cube(200);
    }
    
           
}

module MakePalmTop() {
    difference(){
        PalmTop();
        
        //Cut hole for first bolt holder
        translate([HandScale * 12, 0, HandScale * 84.35]) rotate([90,0,7]) translate([0, 0, -34 * HandScale])  cylinder(d=PalmBoltDiameter, h=100 * HandScale,center=false, $fn=20);
        
        //Cut hole for second bolt holder
        translate([HandScale * -32.767, 0,HandScale * 76.472]) rotate([90,0,7]) translate([0, 0,  -28 * HandScale]) cylinder(d=PalmBoltDiameter , h=100 * HandScale,center=false, $fn=20);
        
        
       
    }
   
     
    //Add inner threads for first bolt holder
    translate([HandScale * 12, 0, HandScale * 84.35]) rotate([90,0,7]) translate([0, 0, -35 * HandScale]) thread_in(PalmBoltDiameter, 13 * HandScale);
    
    //Add inner threads for second bolt holder
    translate([HandScale * -32.767, 0,HandScale * 76.472]) rotate([90,0,7]) translate([0, 0,  -29 * HandScale])  thread_in(PalmBoltDiameter, 13 * HandScale);
   
}

module MakeThermoform1() {
    
    
   difference(){
        Thermoform1();
        // cut large hole for wrist bolt 
       // the -0.05 on bolt diamter is to make sure threads attach to walls
        translate([251.379 * ForeArmCircumferenceScale, 15.135 * ForeArmCircumferenceScale, -(61.5* ArmScale) + (26* HandScale)/2 ]) 
        cylinder(d = WristBoltDia - 0.05, h = 67.00 * ArmScale, center=true, $fn=30);
                
    }
    
    difference(){
        
        //Add inner threads for wrist bolt holder
        translate([251.379 * ForeArmCircumferenceScale, 15.135 * ForeArmCircumferenceScale, -(20 * HandScale + 40 * ArmScale) +(-3* HandScale) ])  
        thread_in(WristBoltDia, 23 * HandScale + 40 * ArmScale);
      
        // truncate threads length to wrist end
        translate([251.379 * ForeArmCircumferenceScale - 100, 15.135 * ForeArmCircumferenceScale - 100, -(38* ArmScale)-0.5])
        cube(200);
        
    }
        
}

module MakeThermoform3() {
    
    difference(){
        Thermoform3();
        
        //Cut hole for first elbow bolt holder
        translate([ForeArmCircumferenceScale * 293.127, ForeArmCircumferenceScale * 24.432, ArmScale * -296.208]) 
        rotate([0,90,0]) 
        translate([0, 0, -90 * ForeArmCircumferenceScale]) 
        cylinder(d=ElbowBoltDiameter, h=100 * ForeArmCircumferenceScale,center=false, $fn=20);
       
    }
    
    //Add inner threads for elbow bolt holder
    translate([ForeArmCircumferenceScale * 293.127, ForeArmCircumferenceScale * 24.432, ArmScale * -296.208]) 
    rotate([0,90,0])
    translate([0, 0, -77 * ForeArmCircumferenceScale]) 
    thread_in(ElbowBoltDiameter, 77 * ArmScale);
}

//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);


module make_bolt(dia,hi, headhi, headDiameter)
// make an ISO bolt 
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
//rotate for better print orientation
rotate([-90,0,0]) 
    difference() {
        union()
        {   
            difference() {
            cylinder(d = headDiameter, h = headhi, $fn=30);
            
                // Make head rounded
                difference() {
                    
                    pad = 0.1; // Padding to maintain manifold
                    r = 1; // radius of fillet
                    cr = headDiameter/2;
                        
                    rotate_extrude(convexity=10, $fn = 30) translate([cr-r+pad, -pad, 0]) square(r+pad,r+pad);
                    rotate_extrude(convexity=10, $fn = 30) translate([cr-r, r, 0]) circle(r=r,$fn=30);
                    }
       
            }
            translate([0,0,headhi-0.1]) thread_out_centre(dia,hi+0.1);
            translate([0,0,headhi-0.1]) thread_out(dia,hi+0.1);
        }
        
        // make the hex hole
        translate([0,0,-1]) rotate([0,0,45]) cylinder(d = dia - 2 ,h = dia, $fn=4);
     
        //flatten one side to make it printable
        translate([-hi, dia/2 - dia/12, -1]) cube(hi *2);   
        
        //flatten other side to make threads not wavy on top
        translate([-hi,- (hi *2) - (dia/2 - dia/14), headhi + 0.1]) cube(hi *2);   
    }
    
         
}

module thread_out(dia,hi,thr=$fn)
// make an outside ISO thread (as used on a bolt)
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_out_pitch(dia,hi,p,thr);
}

module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
    //JB: I add this mirror because the model will be mirrored at the end if it is a left
    if (LeftRight == "Left") {
            mirror([0,1,0]) thread_in_pitch(dia,hi,p,thr); 
    } else
            thread_in_pitch(dia,hi,p,thr);  
}

module thread_out_pitch(dia,hi,p,thr=$fn)
// make an outside thread (as used on a bolt) with supplied pitch
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of full turns
	n=r/(p/thr);			// number of segments for remainder
	// do full turns
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_out_turn(dia,p,thr);
	// do remainder
	for(sg=[0:n])
		th_out_pt(Rmin-0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_in_pitch(dia,hi,p,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of turns
	n=r/(p/thr);			// number of segments for remainder
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_in_turn(dia,p,thr);
	for(sg=[0:n])
		th_in_pt(Rmin,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_out_centre(dia,hi)
{
	p = get_coarse_pitch(dia);
	thread_out_centre_pitch(dia,hi,p);
}

module thread_out_centre_pitch(dia,hi,p)
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin

	cylinder(r = Rmin, h = hi);
}

module thread_in_ring(dia,hi,thk)
{
	difference()
	{
		cylinder(d = dia,h = hi);
		translate([0,0,-1]) cylinder(d = dia - thk*2, h = hi + 1);
	}
}

//--low level bolt modules-----------------------------------------------------------

module th_out_turn(dia,p,thr=$fn)
// make a single turn of an outside thread
//  dia=diameter, 6=M6 etc
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_out_pt(Rmin-0.1,p,s,sg,thr,h,p/thr);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// make a part of an outside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = (sg % thr) * s ;			// angle to start of seg
	ae = as + s  - (s/100) + 0.2;		// angle to end of seg (with overlap) JB: The 0.2 makes the segments link
	z = sh*sg;
	//pp = p/2;
	//   1,4
	//   |\
	//   | \  2,5
 	//   | / 
	//   |/
	//   0,3
	//  view from front (x & z) extruded in y by sg
	//  
	//echo(str("as=",as,", ae=",ae," z=",z));
	polyhedron(
		points = [
			[cos(as)*rt,sin(as)*rt,z],								// 0
			[cos(as)*rt,sin(as)*rt,z+(3/4*p)],						// 1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/8*p)],		// 2
			[cos(ae)*rt,sin(ae)*rt,z+sh],							// 3
			[cos(ae)*rt,sin(ae)*rt,z+(3/4*p)+sh],					// 4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh+(3/8*p)]],	// 5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module th_in_turn(dia,p,thr=$fn)
// make an single turn of an inside thread
//  dia = diameter, 6=M6 etc
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_in_pt(Rmin,p,s,sg,thr,h,p/thr);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// make a part of an inside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100) + 0.2;		// angle to end of seg (with overlap) JB: The 0.2 makes the segments link
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//     1,4 / | 
 	//         \ |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}


module Palm() {scale([HandScale,HandScale,HandScale]) import("o_Palm.stl", convexity=3);}

module WristArmAttach() {scale([HandScale,HandScale,HandScale]) import("o_WristArmAttach.stl", convexity=3);}

module PencilHolderTool() {scale([HandScale,HandScale,HandScale]) import("o_PencilHolderTool.stl", convexity=3);}

module PalmTop() {scale([HandScale,HandScale,HandScale]) import("o_PalmTop.stl", convexity=3);}

module IndexFingerEnd() {scale([HandScale,HandScale,HandScale]) import("o_IndexFingerEnd.stl", convexity=3);}

module IndexFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_IndexFingerPhalanx.stl", convexity=3);}

module MiddleFingerEnd() {scale([HandScale,HandScale,HandScale]) import("o_MiddleFingerEnd.stl", convexity=3);}

module MiddleFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_MiddleFingerPhalanx.stl", convexity=3);}

module PinkyFingerEnd() {scale([HandScale,HandScale,HandScale]) import("o_PinkyFingerEnd.stl", convexity=3);}

module PinkyFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_PinkyFingerPhalanx.stl", convexity=3);}

module RingFingerEnd() {scale([HandScale,HandScale,HandScale]) import("o_RingFingerEnd.stl", convexity=3);}

module RingFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_RingFingerPhalanx.stl", convexity=3);}

module ThumbEnd() {scale([HandScale,HandScale,HandScale]) import("o_ThumbEnd.stl", convexity=3);}

module ThumbPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_ThumbPhalanx.stl", convexity=3);}

module WhippleTreePrimary() {scale([HandScale,HandScale,HandScale]) import("o_WhippleTreePrimary.stl", convexity=3);}

module WhippleTreeSecondary() {scale([HandScale,HandScale,HandScale]) import("o_WhippleTreeSecondary.stl", convexity=3);}

module Arm1of1() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm1of1.stl", convexity=3); }

module Arm1of2() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm1of2.stl", convexity=3); }

module Arm2of2() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm2of2.stl", convexity=3); }

module Arm1of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm1of4.stl", convexity=3); }

module Arm2of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm2of4.stl", convexity=3); }

module Arm3of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm3of4.stl", convexity=3); }

module Arm4of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Arm4of4.stl", convexity=3); }

module LatchBase() {scale([ArmScale,ArmScale,ArmScale]) import("o_Latch.stl", convexity=3); }

module LatchSlider() {scale([ArmScale,ArmScale,ArmScale]) import("o_LatchSlider.stl", convexity=3); }

module LatchPin() {scale([ArmScale,ArmScale,ArmScale]) import("o_LatchPin.stl", convexity=3); }

module LatchTeeth() {scale([ArmScale,ArmScale,ArmScale]) import("o_LatchTeeth.stl", convexity=3); }

module LatchHole() {scale([ArmScale,ArmScale,ArmScale]) import("o_LatchHingeHole.stl", convexity=3); }

module Cuff() {scale([CuffScale,CuffScale,CuffScale]) import("o_Cuff.stl", convexity=3); }

module Tensioner() {scale([CuffScale,CuffScale,CuffScale]) import("o_Tensioner.stl", convexity=3); }

module Thermoform1() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmScale]) import("o_Thermoform1.stl", convexity=3); }

module Thermoform2() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmScale]) import("o_Thermoform2.stl", convexity=3); }

module Thermoform3() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmScale]) import("o_Thermoform3.stl", convexity=3); }

module Cover1of1() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover1of1.stl", convexity=3); }

module Cover1of2() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover1of2.stl", convexity=3); }

module Cover2of2() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover2of2.stl", convexity=3); }

module Cover1of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover1of4.stl", convexity=3); }

module Cover2of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover2of4.stl", convexity=3); }

module Cover3of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover3of4.stl", convexity=3); }

module Cover4of4() {scale([ForeArmCircumferenceScale,ArmScale,ArmScale]) import("o_Cover4of4.stl", convexity=3); }

