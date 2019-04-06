/*MANUFACTURING*/
$fn=500; // Circle resolution
h_man=5;


r = 50;
rw = 10;
cut = 0.3;
h = 80;

uy_bow(r,rw,cut);
//uy_bow_base(r,rw);

    
module umayyad_arc_1(){
    
    
    
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