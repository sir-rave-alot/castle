
/*MANUFACTURING*/
$fn=500; // Circle resolution
h_man=5;

/* GLOBAL MODEL VARIABLES -- MUST BE DEFINED!! */
w_unit = 30; // merlon total width
h_unit = 30; // merlon total height

h_floor = 90;
os_top = -20;


/*TOWER VARIABLES*/
nof_merlon_tower = 5;
h_tower = 300;
w_win_tower=20;
h_win_tower=50;
/*WALL VARIABLES*/
nof_merlon_wall = 15;
h_wall = 150;
h_gate=120;
w_gate=100;

um_arc_w = 28;
um_arc_t = 10;

/**********************************************************************/

//tower_1_f(nof_merlon_tower, h_tower,w_win_tower,h_win_tower);
translate([-160,0]){
tower_1_s(nof_merlon_tower, h_tower,w_win_tower,h_win_tower);
    }
translate([460,0]){
tower_1_s(nof_merlon_tower, h_tower,w_win_tower,h_win_tower);
    } 

wall_basic_f(nof_merlon_wall,h_wall,w_gate, h_gate);
translate([0,-200]){
wall_basic_b(nof_merlon_wall,h_wall,um_arc_w,um_arc_t);
    }     
    
    //umayyad_arc_1(um_arc_w,um_arc_t);
/**********************************************************************/



/******************************/
/* UMAYYAD ARC MODULES  */
/******************************/
module umayyad_arc_1(r,rw){
    width = r + rw;

    cut = 0.3;
    
    stand_w1= r/2;
    stand_h1 = r/8;
    stand_w2= 1.5*r/4;
    stand_h2 = 1.2*r/4;

    stand_depth=r/8;
    stand_h=2.2*r;
    stand_w=stand_depth*2;

    h = 2*r;
    
    translate([(r+rw),stand_h1+stand_h]){
        uy_bow(r,rw,cut);
        socket(stand_w1, stand_h1, stand_w2, stand_h2,width);    
        
        translate([-width+stand_depth,-stand_h/2]){
            pillar(stand_w,stand_h,stand_depth,stand_w2,stand_h2);
        }
        
        translate([width-stand_depth,-stand_h/2]){
            mirror([1,0,0]){
                pillar(stand_w,stand_h,stand_depth,stand_w2,stand_h2);
                }
        }
    }//end shift
        
     
}

module pillar(w,h,b,stand_w2,stand_h2){
    
    r = (4*b*b + h*h)/(8*b);
    kos = r - b;
    
    intersection(){
        square([w, h], center = true);
        translate([-kos,0]){
                circle(r);
            }
        }
        
        translate([0,-h/2]){
        square([stand_w2/2,stand_h2],center=false);
        }
        
        translate([-h_man,-h/2 - h_man]){
            plug_cutout();
        }
    }    
    
module socket(stand_w1, stand_h1, stand_w2, stand_h2, width){
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


/********************/
/* WALL MODULES */
/********************/
 module wall_basic_b(n,h,wg,t){
     
    difference(){
        wall_basic_basic(n,h);
           
           translate([4*h_man,0]){
            square([n*w_unit-2*3*h_man, 4*wg], center=false);    
        }

        }
        intersection(){
        for(i=[-3:3]){
            translate([(n*w_unit/2)-(wg)-h_man +(-i*(2*wg+2*t)),0]){
                umayyad_arc_1(wg,t);
            }
        }
        translate([4*h_man,0]){
            square([n*w_unit-2*3*h_man, 4.3*wg], center=false);    
        }
    }
    }
    
    module wall_basic_f(n,h,wg,hg){
    difference(){
        wall_basic_basic(n,h);
        translate([(n*w_unit/2)-(wg/2)+h_man,0]){
            window_r_1(wg,hg);
            }
        }
    }
    module wall_basic_basic(n,h,ost){
        
    translate([h_man, h_man+h]){
    difference(){
    union(){
        for(i=[0:n-1]){
            translate([i*w_unit,-0.0001]){
                merlon();
                }
            }
         translate([0,-h]){
             square([n*w_unit, h]);
             }
             
        // LEFT PLUGS
        for(i = [1:2:h/h_man]){
            translate([-h_man, -i*h_man]){
                plug_cutout();
                }
            }
          
        // BOTTOM PLUGS
        for(i = [1:2:n*w_unit/h_man]){
            translate([i*h_man, -h-h_man+0.001]){
                plug_cutout();
                }
            }
        // LEFT PLUGS
        for(i = [1:2:h/h_man]){
            translate([n*w_unit, -i*h_man]){
                plug_cutout();
                }
            }    
            
             
        } // end union
        
        
        translate([0,-h+2*h_man]){
          for(j=[1:3]){
            translate([0,j*h_floor-os_top]){                                     
                for(k=[1:2:n*w_unit/h_man-2]){
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
    

/********************/
/*TOWER MODULES*/
/********************/    
module tower_1_s(n,h,win_w,win_h){
    
    difference(){
        tower_basic_s(n,h);
        
        for(j=[1:2]){
            translate([0,j*h_floor+os_floor]){                    
                for(i=[1:3]){
                    translate([((i*w_unit*n)/4 - win_w/2)+h_man,(j*h_floor)+4*h_man]){
                        window_r_1(win_w,win_h);
                        }
                    } // end windows
                }
            }
            
        for(j=[1:3]){
            translate([0,j*h_floor+os_floor]){                                     
                for(k=[2:2:w_unit*n/h_man-1]){
                    translate([k*h_man,j*h_floor+2*h_man]){
                        plug_cutout();
                        }
                    } // end floors
                    
                }
            }            
            
           
    } // end difference
}

module tower_1_f(n,h,win_w,win_h){
    
    difference(){
        tower_basic_f(n,h);
        
        for(j=[1:2]){
            translate([0,j*h_floor+os_floor]){                    
                for(i=[1:3]){
                    translate([((i*w_unit*n)/4 - win_w/2)+h_man,(j*h_floor)+4*h_man]){
                        window_r_1(win_w,win_h);
                        }
                    } // end windows
                }
            }
            
        for(j=[1:3]){
            translate([0,j*h_floor+os_floor]){                                     
                for(k=[2:2:w_unit*n/h_man-1]){
                    translate([k*h_man,j*h_floor+2*h_man]){
                        plug_cutout();
                        }
                    } // end floors
                    
                }
            }            
            
           
    } // end difference
}

module tower_basic_s(n,h){
    
   translate([h_man,h_tower+h_man]){
       union(){ // Plug cutouts
        tower_basic_basic(n,h);
        
        // LEFT PLUGS
        for(i = [1:2:h_tower/h_man]){
            translate([-h_man, -i*h_man]){
                plug_cutout();
                }
            }

        // RIGHT PLUGS
        for(i = [1:2:h_tower/h_man]){
            translate([w_unit*n, -i*h_man]){
                plug_cutout();
                }
            }

        // BOTTOM PLUGS
        for(i = [1:2:w_unit*n/h_man]){
            translate([i*h_man,-h_tower-h_man]){
                plug_cutout();
                }
            }  
    } // end difference
  }
} // end tower

module tower_basic_f(n,h){
    
   translate([h_man,h_tower+h_man]){
       union(){ // Plug cutouts
        tower_basic_basic(n,h);
        
        // LEFT PLUGS
        for(i = [2:2:h_tower/h_man]){
            translate([-h_man, -i*h_man]){
                plug_cutout();
                }
            }

        // RIGHT PLUGS
        for(i = [2:2:h_tower/h_man]){
            translate([w_unit*n, -i*h_man]){
                plug_cutout();
                }
            }

        // BOTTOM PLUGS
        for(i = [1:2:w_unit*n/h_man]){
            translate([i*h_man,-h_tower-h_man]){
                plug_cutout();
                }
            }  
    } // end difference
  }
} // end tower


module tower_basic_basic(n,h){    
            union(){
            for(i = [0:n-1]){
                translate([i*w_unit,-0.001]){
                    merlon();
                }
            }
            translate([0,-h]){
                square([n*h_unit, h]);
                }
        } // end union  
    }



module merlon(w,h){
    l_merlon = (2/3)*w_unit; // edge length
    h_merlon = (1/3)*w_unit; // edge hight
    r_merlon = (1/3)*w_unit; // cutout radius
    cd_merlon=1.5; // cutout depth (factor r_merlon)
    d_merlon = (1/6)*w_unit; // distance between merlon edges
    outline_merlon = [(l_merlon),(h_merlon+2*r_merlon)];
    
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