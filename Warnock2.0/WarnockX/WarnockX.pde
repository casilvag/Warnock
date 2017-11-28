import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;

PImage img;
int ya=0;
int max_Tri;
int t=0;
int lim = 10;
int current = 0;
float n;
float Pi;
float peque=0.1;


IntDict zcolor;

myTriangle[] allTriang;
Scene scene;

float ancho;
  float profundidad;
  float altura;

PVector v1, v2,v3,v4;

boolean inScan;
boolean inGrid;
void setup() {
  //size(750, 750,P3D);
  size(375, 375,P3D);
  scene = new Scene(this);
  scene.setGridVisualHint(false);
  //desde este punto es que tomo la "foto" de la imagen que se guarda , toca cambiarla de últimas
  //scene.camera().setPosition(new Vec(75, 75, -130));
  scene.camera().setPosition(new Vec(37.5, 37.5, -65));
  scene.camera().setOrientation(3.1416,0);
  /*
  ancho=150;
  profundidad=0;
  altura=150;
  */
  ancho=150/2;
  profundidad=0;
  altura=150/2;

  max_Tri=3; //límite máximo de triangulos que se van a dibujar
  n= random(3,max_Tri);
  allTriang= new myTriangle[int(n)];
  generateTriangles(int(n));

  v1=new PVector(0,0);
  v2=new PVector(ancho,0);
  v3=new PVector(ancho,ancho);
  v4=new PVector(0,ancho);
  inScan=false;
  inGrid=false;

  zcolor=new IntDict();
}

void draw() {
  background(0);
  drawAllTriangles(int(n));

    //stroke(255,0,0);
    stroke(255,255,255);
    noFill();
  //Planos de proyecciones
  //1
    //fill(255,0,255,150);
    beginShape(QUADS);
    vertex(0,ancho, altura);
    vertex(0,0,altura);
    vertex(0,0,0);
    vertex(0,ancho,0);
    endShape(CLOSE);
  //2
    //fill(0,255,255,150);
    beginShape(QUADS);
    vertex(ancho, 0, altura);
    vertex(0, 0,altura);
    vertex(0, 0,0);
    vertex(ancho, 0, 0);
    endShape(CLOSE);
  //3
  fill(255,255,255);
    beginShape(QUADS);
    vertex(ancho, ancho, peque);
    vertex(0 ,ancho,peque);
    vertex(0, 0,peque);
    vertex(ancho, 0,peque);
    endShape(CLOSE);

    if(ya==0){
      save("PlanoXY.jpg");
      img = loadImage("PlanoXY.jpg");
      ya=+1;
    }
    //Warnock
    if (current==0 && ya!=1){
     background(255,255,255);
     ya=2;
    }
    rotateY(3.1416);
    //translate(-150,0);
    translate(-150/2,0);
    //revisar(0,150,0,150, current);
    revisar(0,150/2,0,150/2, current);
    //img.resize(150, 150);
    img.resize(150/2, 150/2);

//esta linea es para mostrar la imagen, la de abajo, parce jajajaja hubiera dicho hace much
    //image(img,0,0);

    /*
    if(!inScan){
      inScan=true;
      scanQuad(v1,v2,v3,v4);
    }
    */
    //translate(ancho/2, altura/2, 0);
}



//----------------------------------
void generateTriangles(int n) {
  float x1,y1,x2,y2,x3,y3,z;
  color back,border;
  for (int i = 0; i < n; i++ ) {
    back=color(random(255), random(255), random(255));
    border=color(random(255), random(255), random(255));
    //límites de dimensiones de los triángulos
    /*x1=random(50, 150);//x punto 1
    y1=random(50, 150);//y punto 1
    x2=random(50, 150);//x punto 2
    y2=random(50, 150);//y punto 2
    x3=random(50, 150);//x punto 3
    y3=random(50, 150);//y punto 3
    z=random(50, 150);//y punto 3
*/
    x1=random(50/2, 150/2);//x punto 1
    y1=random(50/2, 150/2);//y punto 1
    x2=random(50/2, 150/2);//x punto 2
    y2=random(50/2, 150/2);//y punto 2
    x3=random(50/2, 150/2);//x punto 3
    y3=random(50/2, 150/2);//y punto 3
    z=random(50/2, 150/2);//y punto 3

    allTriang[i]= new myTriangle(x1,y1,x2,y2,x3,y3,z,back,border);
  }
}

void drawAllTriangles(int n){
  for (int i = 0; i < n; i++ ) {
    if(t==0){
    allTriang[i].drawTriangle();
    }
    allTriang[i].drawTrianglePlaneXY();
    //allTriang[i].drawTrianglePlaneXZ();
    //allTriang[i].drawTrianglePlaneYZ();
    }

    //print(zcolor);
}

void ligne(PVector u, PVector u1) {
  line(u.x, u.y, u.z, u1.x, u1.y, u1.z);
}


class myTriangle{
  float x1,y1,x2,y2,x3,y3,z;
  color back,border;

  myTriangle(float _x1,float _y1,float _x2,float _y2, float _x3, float _y3, float _z, color _back, color _border){
    this.x1=_x1;
    this.y1=_y1;
    this.x2=_x2;
    this.y2=_y2;
    this.x3=_x3;
    this.y3=_y3;
    this.z=_z;
    this.back=_back;
    this.border=_border;
  }

  void drawTriangle(){
    fill(back);
    strokeWeight(2);
    //stroke(back);
    beginShape(TRIANGLES);
      vertex(x1, y1, z);
      vertex(x2, y2, z);
      vertex(x3, y3, z);
    endShape();
    zcolor.add(str(back),int(z));
  };

  void drawTrianglePlaneXY(){
    fill(back);
    noStroke();
    beginShape(TRIANGLES);
      vertex(x1, y1, z/2000);
      vertex(x2, y2, z/2000);
      vertex(x3, y3, z/2000);
    endShape();
  };
/*
  void drawTrianglePlaneYZ(){
    fill(back);
    strokeWeight(2);
    //stroke(border);
    beginShape(TRIANGLES);
      vertex(peque/2, y1, z);
      vertex(peque/2, y2, z);
      vertex(peque/2, y3, z);
    endShape();
  };

  void drawTrianglePlaneXZ(){
    fill(back);
    strokeWeight(2);
    //stroke(border);
    beginShape(TRIANGLES);
      vertex(x1, peque/2, z);
      vertex(x2, peque/2, z);
      vertex(x3, peque/2, z);
    endShape();
  };
*/
}

void keyPressed() {
  if (key == 't'){
    t = 1;
  }
  if (key == 'T'){
    t = 0;
  }
  if (key == ' '){
    current = current < lim ? current+1 : 0;
  }
  if (key == '5'){
    if (inGrid==false){
      inGrid=true;
    }
    else{
      inGrid=false;
    }
  }
}
//----------------
//warnock

void revisar (int x1, int x2, int y1, int y2, int lim){
     int c = 0;
     boolean aux = true;
     loadPixels();
     img.loadPixels();
     for (int x=x1; x<x2;++x){
      for (int y=y1; y<y2;++y){
        int loc = x + y * img.width;

        float r = red(img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue(img.pixels[loc]);
      //jaja nada mk, pero porque sale todo blanco jaja, donde le hizo eso, esta una chimba :v ahi si ya queda tramado el man :V toca es reducir el tamaño para que lo haga mas rapido
      //
        if (color(r,g,b) != -1 ){
          if (c !=color(r,g,b) ){
            if (c!=0){
              aux = false;
            }else{
              c=color(r,g,b);
            }
          }
        }

      }
   }

   if (aux || lim ==0){
     pintar (x1,x2,y1,y2);
   }else if (lim>0){
     int x3 = (x2-x1) /2 + x1 ;
     int y3 = (y2-y1) /2 + y1;
     revisar (x1, x3, y1, y3, lim-1);
     revisar (x3, x2, y1, y3, lim-1);
     revisar (x1, x3, y3, y2, lim-1);
     revisar (x3, x2, y3, y2, lim-1);
   }
}

void pintar(int x1,int x2,int y1,int y2){
   loadPixels();
   img.loadPixels();
   for (int x=x1; x<x2;++x){
      for (int y=y1; y<y2;++y){
        int loc = x + y * img.width;
        int loc2 = x + y * width;
        float r = red(img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue(img.pixels[loc]);
        if (color(r,g,b) != -1){
          pixels[loc2] = color(r,g,b);
          pushMatrix();
          noStroke();
          fill(r,g,b);
          rect(x1,y1,x2-x1,y2-y1);
          popMatrix();
        }
        else{
          pushMatrix();
          noStroke();
          fill(255);
          rect(x1,y1,x2-x1,y2-y1);
          popMatrix();
        }
      }
   }
   updatePixels();
   if(inGrid==true){
     stroke (200,0,0);
   }
   else{
     noStroke();
   }
   line (x1,y1, x1, y2);
   line (x2,y1, x2, y2);
   line (x1, y1, x2, y1);
   line (x1, y2, x2, y2);
}
