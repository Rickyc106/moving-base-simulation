// ** TO-DO: FIX KEYBOARD LAG
// ** TO-DO: MULTIPLE KEYBOARD INPUT

int sm = 100;
int la = 300;

float steer_angle = 90;
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

void setup() {
  size(400,400);
}

void draw() {
  float steer_x = 0;
  float steer_y = 0;
  
  float trans_x = 0; 
  float trans_y = 0;
  
  background(255);
  
  strokeWeight(1);
  stroke(255,0,0);
  
  if (keyPressed) {
    if (key == 'e') {
      steer_x = steer_mag * cos(radians(steer_angle));
      steer_y = steer_mag * sin(radians(steer_angle));
      steer_angle += 1;
    }
    else if (key == 'q') {
      steer_x = steer_mag * cos(radians(steer_angle));
      steer_y = steer_mag * sin(radians(steer_angle));
      steer_angle -= 1;
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
  
  for (int i = 0; i < 4; i++){
    lines[i][2] -= steer_x;
    lines[i][3] -= steer_y;
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