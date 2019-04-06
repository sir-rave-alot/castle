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
h_tower = 360;

/*EXECUTE*/
tower_f();

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


module tower_f(){
   
    difference(){ // Plug cutouts
        union(){
            for(i = [0:nof_merlon_tower-1]){
                translate([i*(d_merlon+l_merlon+d_merlon),0]){
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
} // end tower

module plug_cutout(){
    square(h_man);
} // end plug_cutout
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    