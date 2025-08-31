int num = 02;   
int range = 50;    

float[] ax = new float[num];
float[] ay = new float[num];

boolean dragging = false;   
color currentCol;           
void setup() {
  size(800, 800);             
  background(255);          
  frameRate(30);
  
  for (int i = 0; i < num; i++) {
    ax[i] = width/2;
    ay[i] = height/2;
  }

  currentCol = color(0); 
}

void draw() {
  
  for (int i = 1; i < num; i++) {
    ax[i-1] = ax[i];
    ay[i-1] = ay[i];
  }

  if (dragging) {
    
    ax[num-1] = mouseX;
    ay[num-1] = mouseY;
  } else {
    
    ax[num-1] += random(-range, range);
    ay[num-1] += random(-range, range);
    ax[num-1] = constrain(ax[num-1], 0, width);
    ay[num-1] = constrain(ay[num-1], 0, height);
  }

  strokeWeight(90);
  for (int i = 1; i < num; i++) {
    float a = map(i, 1, num, 20, 255); 
    stroke(red(currentCol), green(currentCol), blue(currentCol), a);
    line(ax[i-1], ay[i-1], ax[i], ay[i]);
  }
}

void mousePressed() {
  dragging = true;
  currentCol = color(random(255), random(255), random(255));
 
  if (mouseButton == RIGHT) {
    String fn = "arte-" + year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(fn);           
    background(255);          
    for (int i = 0; i < num; i++) {
      ax[i] = mouseX;
      ay[i] = mouseY;
    }
  }
}

void mouseReleased() {
  dragging = false;
}
