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
h_gate=100;
w_gate=100;

/*EXECUTE*/

wall_basic_basic(nof_merlon_wall,h_wall);

//window_frame_r_1(win_w_tower, win_h_tower,5);




/*MODULES*/

module wall_basic_f(n,h,wg,hg){
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

/*MANUFACTURING*/
module plug_cutout(){
    square(h_man);
} // end plug_cutout
    
    
