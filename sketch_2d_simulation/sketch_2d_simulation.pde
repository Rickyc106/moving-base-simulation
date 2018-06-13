// ** TO-DO: FIX KEYBOARD LAG
// ** TO-DO: MULTIPLE KEYBOARD INPUT

int sm = 100;
int la = 300;

float steer_angle = 270;
float steer_mag = 30;

float[][] points = {  {sm, sm},    // Top left
                      {la, sm},    // Top Right
                      {sm, la},    // Bot Left
                      {la, la}  };    // Bot Right
                      
float[][] lines = {  {sm, sm, sm, sm - steer_mag},    // Top Left
                     {la, sm, la, sm - steer_mag},    // Top Right
                     {sm, la, sm, la - steer_mag},    // Bot Left
                     {la, la, la, la - steer_mag}  };    // Bot Right

float speed = 0.5;

float steer_x = 0;
float steer_y = 0;

boolean keys[] = new boolean [6];

void setup() {
  size(400,400);
}

void draw() {
  float trans_x = 0; 
  float trans_y = 0;
  
  background(255);
  
  strokeWeight(1);
  stroke(255,0,0);
  
  /*
  
  if (keyPressed) {
    if (key == 'e') {
      steer_x = steer_mag * cos(radians(steer_angle));
      steer_y = steer_mag * sin(radians(steer_angle));
      steer_angle += 1;
      steer_angle = steer_angle % 360;
    }
    else if (key == 'q') {
      steer_x = steer_mag * cos(radians(steer_angle));
      steer_y = steer_mag * sin(radians(steer_angle));
      steer_angle -= 1;
      steer_angle = steer_angle % 360;
    }
  }
  
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      trans_y -= speed;
      for (int i = 0; i < 4; i ++){
        points[i][1] += trans_y;
        lines[i][1] += trans_y;
      }
      println('w');
    }
    else if (key == 's' || key == 'S') {
      trans_y += speed;
      for (int i = 0; i < 4; i ++){
        points[i][1] += trans_y;
        lines[i][1] += trans_y;
      }
      println('s');
    }
    else if (key == 'a' || key == 'A') {
      trans_x -= speed;
      for (int i = 0; i < 4; i ++){
        points[i][0] += trans_x;
        lines[i][0] += trans_x;
      }
      println('a');
    }
    else if (key == 'd' || key == 'D') {
      trans_x += speed;
      for (int i = 0; i < 4; i ++){
        points[i][0] += trans_x;
        lines[i][0] += trans_x;
      }
      println('d');
    }
  }
  
  */
  
  for (int i = 0; i < keys.length; i++) {
    if (keys[i]) {
      switch (i) {
        case 0:  steer_x = steer_mag * cos(radians(steer_angle));
                 steer_y = steer_mag * sin(radians(steer_angle));
                 steer_angle -= 1;
                 steer_angle = steer_angle % 360;
        
        case 1:  trans_y -= speed;
                 for (int j = 0; j < 4; j ++) {
                   points[j][1] += trans_y;
                   lines[j][1] += trans_y;
                 }
                 println('w');
        
        case 2:  steer_x = steer_mag * cos(radians(steer_angle));
                 steer_y = steer_mag * sin(radians(steer_angle));
                 steer_angle += 1;
                 steer_angle = steer_angle % 360;
        
        case 3:  trans_x -= speed;
                 for (int j = 0; j < 4; j ++) {
                   points[j][0] += trans_x;
                   lines[j][0] += trans_x;
                 }
                 println('a');
        
        case 4:  trans_y += speed;
                 for (int j = 0; j < 4; j ++){
                   points[j][1] += trans_y;
                   lines[j][1] += trans_y;
                 }
                 println('s');
        
        case 5:  trans_x += speed;
                 for (int j = 0; j < 4; j ++){
                   points[j][0] += trans_x;
                   lines[j][0] += trans_x;
                 }
                 println('d');
      }
    }
  }
  
  
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
    line(lines[i][0], lines[i][1], lines[i][2], lines[i][3]);
  }
  
  strokeWeight(4);
  stroke(0);
  
  for (int i = 0; i < 4; i++){
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
}

void keyReleased() {
  if (key == 'q') keys[0] = false;
  if (key == 'w') keys[1] = false;
  if (key == 'e') keys[2] = false;
  if (key == 'a') keys[3] = false;
  if (key == 's') keys[4] = false;
  if (key == 'd') keys[5] = false;
}
