/*
CASTLE - R. Andonie
2019-04-06
*/

$fn=500; // Circle resolution

l_merlon = 20; // edge length
h_merlon = 10; // edge hight
r_merlon = 10; // cutout radius
cd_merlon=1.5; // cutout depth (factor r_merlon)
d_merlon = 5; // distance between merlon edges

nof_c_merlons = 20;

/*EXECUTE*/
merlon();

for(i = [0:nof_c_merlons]){
    translate([i*(d_merlon+l_merlon+d_merlon),0]){
        merlon();
    }
}




/*MODULES*/
module merlon(){
    m_outline = [(l_merlon),(h_merlon+2*r_merlon)];
    translate(m_outline/2){ // origin shift
      difference(){
        union(){
            square(m_outline, center=true);
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


module tower(){
    } // end tower