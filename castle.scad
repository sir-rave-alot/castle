/*
CASTLE - R. Andonie
2019-04-06
*/

$fn=500; // Circle resolution

l_merlon = 15;
h_merlon = 10;


r_merlon = 10;

d_merlon = 5; 

/*EXECUTE*/
merlon();


/*Module Description*/
module merlon(){
    m_outline = [(l_merlon+d_merlon),(h_merlon+2*r_merlon)];
    
    difference(){
        square(m_outline, center=true);
        translate([-1.5*r_merlon, 0,0]){
            circle(r_merlon);
            }
        translate([1.5*r_merlon, 0,0]){
            circle(r_merlon);
            }
        }
    
}// end merlon


module tower(){
    } // end tower