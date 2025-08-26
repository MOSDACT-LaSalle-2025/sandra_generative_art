
int num = 800;   
int range = 80;    

float[] ax = new float[num];
float[] ay = new float[num];

boolean dragging = false;   // true mientras presionas el mouse
color currentCol;           // color de la estela

void setup() {
  size(640, 360);
  background(255);          // fondo blanco SOLO al inicio
  frameRate(30);
  
  
  for (int i = 0; i < num; i++) {
    ax[i] = width/2;
    ay[i] = height/2;
  }
  
  // color inicial
  currentCol = color(0); // negro
}

void draw() {
  
  for (int i = 1; i < num; i++) {
    ax[i-1] = ax[i];
    ay[i-1] = ay[i];
  }

  if (dragging) {
    // si presionas, la punta va al mouse
    ax[num-1] = mouseX;
    ay[num-1] = mouseY;
  } else {
    // si no, sigue Brownian
    ax[num-1] += random(-range, range);
    ay[num-1] += random(-range, range);
    ax[num-1] = constrain(ax[num-1], 0, width);
    ay[num-1] = constrain(ay[num-1], 0, height);
  }


  strokeWeight(2);
  for (int i = 1; i < num; i++) {
    float a = map(i, 1, num, 20, 255); // alpha creciente
    stroke(red(currentCol), green(currentCol), blue(currentCol), a);
    line(ax[i-1], ay[i-1], ax[i], ay[i]);
  }
}


void mousePressed() {
  dragging = true;
  currentCol = color(random(255), random(255), random(255));
  
  // 👉 Si es botón derecho: GUARDAR captura, luego borrar y reiniciar
  if (mouseButton == RIGHT) {
    String fn = "arte-" + year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
    saveFrame(fn);            // guarda PNG en la carpeta del sketch

    background(255);          // limpiar a blanco
    for (int i = 0; i < num; i++) {
      ax[i] = mouseX;
      ay[i] = mouseY;
    }
  }
}
// al soltar: vuelve a modo Brownian
void mouseReleased() {
  dragging = false;
}
