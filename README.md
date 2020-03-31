# PianoTiles Práctica 7 CIU

## Rubén García Quintana

## Introducción a la síntesis y procesamiento de audio

### Introducción
- En esta práctica se nos enseña diferentes herramientas para generar sonido, capturar sonido, dibujar las ondas, etc. La tarea final consiste en crear algún prototipo que integrara gráficos y sonido. En mi caso, he obtado por realizar un juego parecido al conocido juego PianoTiles para dispositivos moviles.

![](gifPiano.gif)

### Desarrollo

- Para la práctica se ha usado, ejemplos presentados en los videos explicativos y además se han usado hilos para crear las notas que se desplazan.



```

if(count>250){
    count=0;
    crear=true;
  }
  if(crear){
    
    objetos.clear();
    
    for (int i = 0; i < random(4,10); i++) {
    crear=false;
    objetos.add(new objeto(random(15, 45),cesta));
  }
  }

  for (objeto obj : objetos) {
    obj.display();
    obj.caida();
    
  }

```
```
class Marcador{

  float puntos,x;
  public Marcador(float x){
  this.x=x;
  puntos=0;
  }  
  
  void setX(float x2){
    x=x+x2;

  }
    void reset(){
    puntos=0;

  }
  float getPoints(){
    return puntos;

  }

  boolean dentro(float x2,float puntos,float y2){
    if(x2*2>x-43 && x2*2<x+43&& y2 < height-30){
        this.puntos+=puntos;
        return true;
    }
    return false;
  }
}
```



```


class objeto {
  PShape s;
  float x, y;
  float speed,radio,puntos;
  boolean flag;
  Marcador cesta;

  public objeto(float radio,Marcador cesta) {
    fill(255);
    this.cesta=cesta;
    flag=true;
    puntos=100/radio;
    this.radio=radio;
    x = random(width);
    y = 0; 
    s = createShape(ELLIPSE,x,y,radio,radio);
    speed = random(2, 6);
  }
  
  void caida() {
    if(flag){
        y += speed;
    if (y > height-45) {
        if(cesta.dentro(x,puntos,y))puntos=0;

    }else{
      if(y>height-15){ 
        flag=false;
        x = random(width);
        y = 0; 
      }

    }
    
    }

  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    shape(s);
    popMatrix();
  }
}
```




### Instrucciones
  - Enter - Empezar/Terminar entrenamiento.


