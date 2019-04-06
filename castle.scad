/*
CASTLE - R. Andonie
2019-04-06
*/

$fn=500; // Circle resolution

/*MANUFACTURING*/
h_man=5;

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
win_w_tower = 20;
win_h_tower = 50;

h_floor_tower= 100;

/*EXECUTE*/
//tower_basic_f();
tower_1_f();

echo(outline_merlon[1]*nof_merlon_tower);

/*MODULES*/


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


module tower_1_f(){
    difference(){
        tower_basic_f();
        
        for(j=[1:2]){
            translate([0,j*h_floor_tower+2*h_man]){                    
                for(i=[1:3]){
                    translate([(i*outline_merlon[1]*nof_merlon_tower)/4 - win_w_tower/2,0]){
                        window_r_1(win_w_tower,win_h_tower);
                        }
                    }
                }
            }
           
    } // end difference
    
        
    } // end tower_1_f




module tower_basic_f(){
   translate([0,h_tower-h_man]){
       difference(){ // Plug cutouts
        union(){
            for(i = [0:nof_merlon_tower-1]){
                translate([i*(d_merlon+l_merlon+d_merlon),-0.001]){
                    merlon();
                }
            }
            translate([0,-h_tower]){
                square([outline_merlon[1]*nof_merlon_tower, h_tower]);
                }
        } // end union   
        
        // LEFT PLUGS
        for(i = [2:2:h_tower/h_man]){
            translate([0, -i*h_man]){
                plug_cutout();
                }
            }

        // RIGHT PLUGS
        for(i = [2:2:h_tower/h_man]){
            translate([outline_merlon[1]*nof_merlon_tower-h_man, -i*h_man]){
                plug_cutout();
                }
            }

        // RIGHT PLUGS
        for(i = [1:2:outline_merlon[1]*nof_merlon_tower/h_man]){
            translate([i*h_man,-h_tower]){
                plug_cutout();
                }
            }  
    } // end difference
  }
} // end tower




/*MANUFACTURING*/
module plug_cutout(){
    square(h_man);
} // end plug_cutout
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    