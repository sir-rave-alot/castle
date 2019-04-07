/*
CASTLE - R. Andonie
2019-04-06
*/

/*MANUFACTURING*/
$fn=500; // Circle resolution
h_man=5;

/*COMMON*/
h_floor= 100;
os_floor=-20;

/*MERLON VARIABLES*/
l_merlon = 20; // edge length
h_merlon = 10; // edge hight
r_merlon = 10; // cutout radius
cd_merlon=1.5; // cutout depth (factor r_merlon)
d_merlon = 5; // distance between merlon edges
outline_merlon = [(l_merlon),(h_merlon+2*r_merlon)];

/*TOWER VARIABLES*/
nof_merlon_tower = 5;
h_tower = 300;

h_floor_tower= 100;
os_floor_tower=-20;

/*WALL VARIABLES*/
nof_merlon_wall = 15;
h_wall = 150;
h_gate=120;
w_gate=100;

/*EXECUTE*/



translate([0,0]){
wall_basic_b(nof_merlon_wall,h_wall,w_gate,h_gate);
}
//window_frame_r_1(win_w_tower, win_h_tower,5);




/*MODULES*/


module wall_basic_b(n,h,wg,hg){
    difference(){
        wall_basic_basic(n,h);
        translate([(n*(d_merlon+l_merlon+d_merlon)/2)-(width/2)+h_man,0]){
        
            }
        }
    }


module wall_basic_f(n,h,wg,hg){
    difference(){
        wall_basic_basic(n,h);
        translate([(n*(d_merlon+l_merlon+d_merlon)/2)-(wg/2)+h_man,0]){
            window_r_1(wg,hg);
            }
        }
    }


module wall_basic_f(n,h,wg,hg){
    difference(){
        wall_basic_basic(n,h);
        translate([(n*(d_merlon+l_merlon+d_merlon)/2)-(wg/2)+h_man,0]){
            window_r_1(wg,hg);
            }
        }
    }

module wall_basic_basic(n,h){
    translate([h_man, h_man+h]){
    difference(){
    union(){
        for(i=[0:n-1]){
            translate([i*(d_merlon+l_merlon+d_merlon),-0.0001]){
                merlon();
                }
            }
         translate([0,-h]){
             square([n*(d_merlon+l_merlon+d_merlon), h]);
             }
             
        // LEFT PLUGS
        for(i = [1:2:h/h_man]){
            translate([-h_man, -i*h_man]){
                plug_cutout();
                }
            }
          
        // BOTTOM PLUGS
        for(i = [1:2:n*(d_merlon+l_merlon+d_merlon)/h_man]){
            translate([i*h_man, -h-h_man+0.001]){
                plug_cutout();
                }
            }
        // LEFT PLUGS
        for(i = [1:2:h/h_man]){
            translate([n*(d_merlon+l_merlon+d_merlon), -i*h_man]){
                plug_cutout();
                }
            }    
            
             
        } // end union
        translate([0,-h+2*h_man]){
          for(j=[1:3]){
            translate([0,j*h_floor-os_floor]){                                     
                for(k=[1:2:n*(d_merlon+l_merlon+d_merlon)/h_man-2]){
                    translate([k*h_man,0]){
                        plug_cutout();
                        }
                    } // end floors
                    
                }
            }
            }

    } // end difference
    }// end shift
    }



module merlon(){
    m_shift = outline_merlon/2 + [r_merlon/2,0];
    
    translate(m_shift){ // origin shift
      difference(){
        union(){
            square(outline_merlon, center=true);
            translate([l_merlon/2,-(2*h_merlon-r_merlon/2)]){
                square(r_merlon/2, center=false);
                }
            translate([-(l_merlon+r_merlon)/2,-(2*h_merlon-r_merlon/2)]){
                square(r_merlon/2, center=false);
                }
            } // end union
        translate([-cd_merlon*r_merlon, -r_merlon/2]){
            circle(r_merlon);
            }
        translate([cd_merlon*r_merlon, -r_merlon/2]){
            circle(r_merlon);
            }
        } //end difference
    } // end origin shift
}// end merlon

module window_r_1(w,h){
    union(){
        square([w,h-w/2]);
        translate([w/2, h-w/2]){
            circle(w/2);
            }
        }
    }


r = 50;
rw = 10;
stand_h2 = 15;
width = r + rw;

cut = 0.3;
    
module umayyad_arc_1(){
    
    stand_w1= 20;
    stand_h1 = 8;
    stand_w2= 15;
    

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

/*MANUFACTURING*/
module plug_cutout(){
    square(h_man);
} // end plug_cutout
    
    
