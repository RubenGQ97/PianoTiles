
import ddf.minim.*;
import ddf.minim.ugens.*;
Minim minim;
AudioOutput nota;

String [] cancion={"C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4"};
int point,dificultad,aparicion;
boolean menu,fin,tecla1,tecla2,tecla3,tecla4;
ArrayList <Tecla>p;

void setup(){
  size(440,880);
  aparicion=80;
  point=0;  
  dificultad=1;
  menu=true;
  fin=false;
  tecla1=false;
  tecla2=false;
tecla3=false;
tecla4=false;
  p= new ArrayList<Tecla>();
//pista= new Pista(cancion);
minim = new Minim(this);
nota= minim.getLineOut();
}


void draw(){
  
  if(!menu){
      
    
    if(!fin){
    background(255);
    fill(0);
    stroke(0);
    line(110,0,110,height);
    line(220,0,220,height);
    line(330,0,330,height);
    
    if(dificultad==1)aparicion=80;
    if(dificultad==2)aparicion=50;
    if(dificultad==3)aparicion=35;
    if(dificultad==4)aparicion=20;
    
    if (frameCount % aparicion == 0) {
    thread("nuevaNota");
  }
  
  

        for(int k=0;k<p.size();k++){
          p.get(k).move();
    }
        /*teclado*/
    stroke(240,102,155);
    fill(0);
    if(tecla1)fill(59,131,189);
    rect(0,height-85,110,80,7);
    fill(0);
    if(tecla2)fill(59,131,189);
    rect(110,height-85,110,80,7);
    fill(0);
    if(tecla3)fill(59,131,189);
    rect(220,height-85,110,80,7);
    fill(0);
    if(tecla4)fill(59,131,189);
    rect(330,height-85,110,80,7);
    noStroke();
    fill(255);
    textSize(20);
    text("A",50,height-40);
    text("S",160,height-40);
    text("D",270,height-40);
    text("F",380,height-40);
    actualiza();
    fill(255,255,0);
    rect(0,0,width,50);
    fill(0);
    textSize(15);
    text("Puntuación: "+point,20,40);
    textSize(12);
     text("Pulsa 'ENTER' para salir",300,20);
    }else{
    
    background(255);
        fill(0);
    textSize(40);
    text("Puntuación: "+point,width/5,height/2+200);
    textSize(50);
    text("Has Perdido !!",width/6,height/2);
    textSize(20);
    text("Pulsa 'ENTER' para volver al menu",width/6,height/2+300);
    }
  
  
  }else{
  background(255);
  if (frameCount % 10 == 0) {
    thread("nuevaNota");
  }
     for(int k=0;k<p.size();k++){
          p.get(k).setColor((int)random(255),(int)random(255),(int)random(255));
          p.get(k).move();
    }
    fill(0,0,255);
    textSize(50);
    text("Ruben Tiles",2,50);
    fill(0);
    textSize(18);
    text("Esta es una versión de prueba parecida al \nconocido juego de movil 'Piano tiles' realizada \npara la asignatura Creando Interfaces de\nUsuario. Consiste en tocar las notas usando las\nteclas indicadas. Acumula en máximo de puntos\nposible. Si se te escapa alguna nota, pierdes.",25,150);
    textSize(15);
    text("\n\n Cambia de dificultad usando el teclado numerico (1-9)",25,470);
    textSize(30);
    text("DIFICULTAD: "+dificultad,105,400);
    textSize(20);
    text("Pulsa 'ENTER' para empezar",width/6,height/2+300);


  fin=false;
  point=0;
  }
    
}
void keyPressed(){
    
  if(key=='a' || key == 'A'){
    tecla1=true;
    puntos(1);
  }
  if(key=='s' || key == 'S'){
    tecla2=true;
    puntos(2);

}
  if(key=='d' || key == 'D'){
    tecla3=true;
    puntos(3);
}
  if(key=='f' || key == 'F'){
    tecla4=true;
    puntos(4);

}
  
if(key==ENTER){
  p= new ArrayList<Tecla>();
  menu=!menu;

}
if(key=='1' && menu)dificultad=1;
if(key=='2' && menu)dificultad=2;
if(key=='3' && menu)dificultad=3;
if(key=='4' && menu)dificultad=4;


}


void keyReleased(){

  if(key=='a' || key == 'A'){
    tecla1=false;
    
    
  }
  if(key=='s' || key == 'S'){
    tecla2=false;


}
  if(key=='d' || key == 'D'){
    tecla3=false;

}
  if(key=='f' || key == 'F'){
    tecla4=false;


}
  
}





class SineInstrument implements Instrument{
  Oscil wave;
  Line  ampEnv;

  SineInstrument( float frequency )
  {
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }

  void noteOn( float duration )
  {
    ampEnv.activate( duration, 0.5f, 0 );
    wave.patch( nota );
  }

  void noteOff()
  {
    wave.unpatch( nota );
  }
}




void nuevaNota() {
  if(menu){
  if(8<random(1,10)){
  Tecla aux= new Tecla(cancion[(int)random(0,7.5)],10);
  p.add(aux);
  }

  }else{
    Tecla aux= new Tecla(cancion[(int)random(0,7.5)],dificultad *3);
  p.add(aux);
  }
}


void actualiza(){

    for(int k=0;k<p.size();k++){
          if(p.get(k).getY()>height){
          
          p.remove(k);
          if(!menu)fin=true;
          }
          }
          
}

void puntos(int n){
  
      for(int k=0;k<p.size();k++){
        Tecla aux=p.get(k);
          if(aux.getY()<height && aux.getY()+100>height-88){
            switch(n){
            case 1:
                  if(aux.getX()==10){
                    point++;
                    p.remove(k);
                    nota.playNote( 0, 0.6, new SineInstrument( Frequency.ofPitch( aux.getSonido()).asHz() ) );
                  }
            break;
            case 2:
                  if(aux.getX()==120){
                    point++;
                    p.remove(k);
                    nota.playNote( 0, 0.6, new SineInstrument( Frequency.ofPitch( aux.getSonido()).asHz() ) );
                  }
            break;
            case 3:
                  if(aux.getX()==230){
                    point++;
                    p.remove(k);
                    nota.playNote( 0, 0.6, new SineInstrument( Frequency.ofPitch( aux.getSonido()).asHz() ) );
                  }
            break;
            case 4:
                  if(aux.getX()==340){
                    point++;
                    p.remove(k);
                    nota.playNote( 0, 0.6, new SineInstrument( Frequency.ofPitch( aux.getSonido()).asHz() ) );
                  }
            break;
      }
   }
}


}
