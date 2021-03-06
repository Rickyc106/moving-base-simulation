// ** TO-DO: FIX POOR PROGRAMMING
// ** Currently drawing lines, then erasing. Should check then draw

// ** TO-DO: CENTER-MAP BUTTON A LITTLE BUGGY

int sm = 100;
int la = 300;

float[] center = {(sm + la) / 2, (sm + la) / 2};
float points_angle[] = {225, 315, 135, 45};
float[] rotate_angle = {135, 45, 45, 135};
float[] res_angle = new float[4];

float half_dia = sqrt(sq(la - center[0]) + sq(la - center[1]));

float trans_angle;

float steer_angle = 270;
float steer_mag = 30;
float trans_mag = 50;

float[][] points = {  {sm, sm},    // Top left
                      {la, sm},    // Top Right
                      {sm, la},    // Bot Left
                      {la, la}  };    // Bot Right
                      
float[][] lines = {  {sm, sm, sm, sm - steer_mag},    // Top Left
                     {la, sm, la, sm - steer_mag},    // Top Right
                     {sm, la, sm, la - steer_mag},    // Bot Left
                     {la, la, la, la - steer_mag}  };    // Bot Right
                     
float[][] trans_lines = {  {sm, sm, sm, sm},
                           {la, sm, la, sm},
                           {sm, la, sm, la},
                           {la, la, la, la}  };
                           
float[][] res_lines = new float[4][4];
float[][] rotate_lines = new float[4][4];

float speed = 1.0;

float steer_x = 0;
float steer_y = 0;

boolean keys[] = new boolean [7];
boolean ccw = true;

boolean centered = false;

void setup() {
  size(400,400);
}

void draw() {
  float trans_x = 0; 
  float trans_y = 0;
  
  
  
  background(255);
  
  strokeWeight(1);
  stroke(255,0,0);
  
  for (int i = 0; i < keys.length; i++) {
    if (keys[i]) {
      switch (i) {
        case 0:  steer_x = steer_mag * cos(radians(steer_angle));
                 steer_y = steer_mag * sin(radians(steer_angle));
                 
                 steer_angle -= 1;
                 steer_angle = steer_angle % 360;
                 
                 for (int j =0; j < 4; j++) {
                   points_angle[j] -= 1;
                   rotate_angle[j] -= 1;
                 }
                 
                 ccw = true;
                 break;
        
        case 1:  trans_y -= speed;
        
                 if (keys[3]) trans_angle = 225;
                 else if (keys[5]) trans_angle = 315;
                 else trans_angle = 270;
                 
                 if (!centered) {
                   center[1] += trans_y;
                 }
                 println('w');
                 break;
        
        case 2:  steer_x = steer_mag * cos(radians(steer_angle));
                 steer_y = steer_mag * sin(radians(steer_angle));
                 
                 steer_angle += 1;
                 steer_angle = steer_angle % 360;
                 
                 for (int j =0; j < 4; j++) {
                   points_angle[j] += 1;
                   rotate_angle[j] += 1;
                 }
                 
                 ccw = false;
                 break;
        
        case 3:  trans_x -= speed;
                 
                 if (keys[1]) trans_angle = 225;
                 else if (keys[4]) trans_angle = 135;
                 else trans_angle = 180;
                 
                 if (!centered) {
                   center[0] += trans_x;
                 }
                 println('a');
                 break;
        
        case 4:  trans_y += speed;
                 
                 if (keys[3]) trans_angle = 135;
                 else if (keys[5]) trans_angle = 45;
                 else trans_angle = 90;
        
                 if (!centered){
                   center[1] += trans_y;
                 }
                 println('s');
                 break;
        
        case 5:  trans_x += speed;
        
                 if (keys[1]) trans_angle = 315;
                 else if (keys[4]) trans_angle = 45;
                 else trans_angle = 0;
        
                 if (!centered){
                   center[0] += trans_x;
                 }
                 println('d');
                 break;
        
        case 6:  center[0] = (la + sm) / 2;
                 center[1] = (la + sm) / 2;
                 
                 if (centered) centered = false;
                 else centered = true;
      }
      
      for (int j = 0; j < 4; j++) {
        points_angle[j] = points_angle[j] % 360;
       
        points[j][0] = half_dia * cos(radians(points_angle[j])) + center[0];
        points[j][1] = half_dia * sin(radians(points_angle[j])) + center[1];
       
        lines[j][0] = points[j][0];
        lines[j][1] = points[j][1];
        
        trans_lines[j][0] = half_dia * cos(radians(points_angle[j])) + center[0];
        trans_lines[j][1] = half_dia * sin(radians(points_angle[j])) + center[1];
        trans_lines[j][2] = trans_lines[j][0] + trans_mag * cos(radians(trans_angle));
        trans_lines[j][3] = trans_lines[j][1] + trans_mag * sin(radians(trans_angle));
        
        rotate_lines[j][0] = points[j][0];
        rotate_lines[j][1] = points[j][1];
        
        if (ccw) {
          if (j == 1 || j == 3) {
            rotate_lines[j][2] = rotate_lines[j][0] - trans_mag * cos(radians(rotate_angle[j]));    // Original
            rotate_lines[j][3] = rotate_lines[j][1] - trans_mag * sin(radians(rotate_angle[j]));
          }
          else if (j == 0 || j == 2) {
            rotate_lines[j][2] = rotate_lines[j][0] + trans_mag * cos(radians(rotate_angle[j]));
            rotate_lines[j][3] = rotate_lines[j][1] + trans_mag * sin(radians(rotate_angle[j]));
          }
        }
        else {
          if (j == 1 || j == 3) {
            rotate_lines[j][2] = rotate_lines[j][0] + trans_mag * cos(radians(rotate_angle[j]));    // Original
            rotate_lines[j][3] = rotate_lines[j][1] + trans_mag * sin(radians(rotate_angle[j]));
          }
          else if (j == 0 || j == 2) {
            rotate_lines[j][2] = rotate_lines[j][0] - trans_mag * cos(radians(rotate_angle[j]));
            rotate_lines[j][3] = rotate_lines[j][1] - trans_mag * sin(radians(rotate_angle[j]));
          }
        }
        
        if(!keys[0] && !keys[2]) {
          for (int k = 0; k < 4; k++) {
            rotate_lines[k][2] = rotate_lines[k][0];
            rotate_lines[k][3] = rotate_lines[k][1];
          }
        }
        
        if (!keys[1] && !keys[3] && !keys[4] && !keys[5]) {
          for (int k = 0; k < 4; k++) {
            trans_lines[k][2] = trans_lines[k][0];
            trans_lines[k][3] = trans_lines[k][1];
          }
        }
        
        res_lines[j][0] = points[j][0];
        res_lines[j][1] = points[j][1];
        
        res_lines[j][2] = (trans_lines[j][2] - trans_lines[j][0]) + (rotate_lines[j][2] - rotate_lines[j][0]) + res_lines[j][0];
        res_lines[j][3] = (trans_lines[j][3] - trans_lines[j][1]) + (rotate_lines[j][3] - rotate_lines[j][1]) + res_lines[j][1];
      }
    }
    
    if(!keys[0] && !keys[2]) {
      for (int j = 0; j < 4; j++) {
        rotate_lines[j][2] = rotate_lines[j][0];
        rotate_lines[j][3] = rotate_lines[j][1];
      }
    }
    
    if (!keys[1] && !keys[3] && !keys[4] && !keys[5]) {
      for (int j = 0; j < 4; j++) {
        trans_lines[j][2] = trans_lines[j][0];
        trans_lines[j][3] = trans_lines[j][1];
      }
    }
    
    if (!keys[0] && !keys[1] && !keys[2] && !keys[3] && !keys[4] && !keys[5]) {
      for (int j = 0; j < 4; j++) {
        res_lines[j][2] = res_lines[j][0];
        res_lines[j][3] = res_lines[j][1];
      }
    }
  }
  
  //print(rotate_angle[0] + rotate_angle[2] + " ");
  //print(rotate_lines[0][0] + " ");
  //print(rotate_lines[0][1] + " ");
  //print(rotate_lines[0][2] + " ");
  //println(rotate_lines[0][3]);
  
  print(res_lines[0][0] + " ");
  print(res_lines[0][1] + " ");
  print(res_lines[0][2] + " ");
  println(res_lines[0][3]);
  
  if (steer_x == 0 && steer_y == 0) {
    for (int i = 0; i < 4; i++) {
      lines[i][2] = lines[i][0];
      lines[i][3] = lines[i][1] - steer_mag;
    }
  }
  else {
    for (int i = 0; i < 4; i++) {
      lines[i][2] = lines[i][0] + steer_x;
      lines[i][3] = lines[i][1] + steer_y;
    }
  }
  
  for (int i = 0; i < 4; i++){
    //line(lines[i][0], lines[i][1], lines[i][2], lines[i][3]);
  }
  
  stroke(0,0,255);
  for (int i = 0; i < 4; i++){
    line(trans_lines[i][0], trans_lines[i][1], trans_lines[i][2], trans_lines[i][3]);
  }
  
  stroke(15,140,27);
  for (int i = 0; i < 4; i++) {
    line(rotate_lines[i][0], rotate_lines[i][1], rotate_lines[i][2], rotate_lines[i][3]);
  }
  
  stroke(131,27,58);
  for (int i = 0; i < 4; i++) {
    line(res_lines[i][0], res_lines[i][1], res_lines[i][2], res_lines[i][3]);
  }
  
  for (int i = 0; i < 4; i++){
    if (i < 2) {
      strokeWeight(7);
      stroke(0, 255, 255);
    }
    else stroke(0);
    
    point(points[i][0], points[i][1]);
  }
}

void keyPressed() {
  if (key == 'q') keys[0] = true;
  if (key == 'w') keys[1] = true;
  if (key == 'e') keys[2] = true;
  if (key == 'a') keys[3] = true;
  if (key == 's') keys[4] = true;
  if (key == 'd') keys[5] = true;
  if (key == ' ') keys[6] = true;
}

void keyReleased() {
  if (key == 'q') keys[0] = false;
  if (key == 'w') keys[1] = false;
  if (key == 'e') keys[2] = false;
  if (key == 'a') keys[3] = false;
  if (key == 's') keys[4] = false;
  if (key == 'd') keys[5] = false;
  if (key == ' ') keys[6] = false;
}
