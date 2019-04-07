/*MANUFACTURING*/
$fn=500; // Circle resolution
h_man=5;


r = 50;
rw = 10;

width = r + rw;

cut = 0.3;


umayyad_arc_1();


translate([-width+5,-40]){
pillar(10,80,5);

    }

translate([2*width, 0]){
    umayyad_arc_1();
    }

translate([-2*width, 0]){
    umayyad_arc_1();
    }

    
module umayyad_arc_1(){
    
    stand_w1= 20;
    stand_h1 = 8;
    stand_w2= 15;
    stand_h2 = 15;

    stand_depth=5;
    stand_h=100;
    stand_w=stand_depth*2;

    h = 80;
    
        uy_bow(r,rw,cut);
        socket(stand_w1, stand_h1, stand_w2, stand_h1,width);    
        translate([-width+stand_depth,-stand_h/2]){
            pillar(stand_w,stand_h,stand_depth);
        }
        translate([width-stand_depth,-stand_h/2]){
            mirror([1,0,0]){
                pillar(stand_w,stand_h,stand_depth);
                }
        }
     
    }
    
    
    
module pillar(w,h,b){
    
    r = (4*b*b + h*h)/(8*b);
    kos = r - b;
    
    intersection(){
        square([w, h], center = true);
        translate([-kos,0]){
                circle(r);
            }
        }
    }    
    
module socket(stand_w1, stand_h1, stand_w2, stand_h1, width){
    union(){
        translate([width-stand_w1,-stand_h1]){
            square([stand_w1,stand_h1],center=false);
            }
            
         translate([-width,-stand_h1]){
             square([stand_w1,stand_h1],center=false);
             }

        translate([width-stand_w2,-stand_h2]){
            square([stand_w2,stand_h2],center=false);
            }
             
         translate([-width,-stand_h2]){
             square([stand_w2,stand_h2],center=false);
             }

                 
        }
    }
    
module uy_bow(r,d,c){
    translate([0,2*(0.5-c)*(r+d)]){
        difference(){
            uy_bow_base(r,d);
            translate([0,-2*(1-c)*(r+d)]){
                square(2*(r+d), center=true);
                }
            }
        }    
    }    
    
module uy_bow_base(r,d){
    difference(){
        union(){
            circle(r+d);
            translate([0,-(r+d)/2]){
                square([2*(r+d), (r+d)], center=true);
                }
            }
        circle(r);
        }
    }