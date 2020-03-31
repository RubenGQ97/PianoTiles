


class Tecla {
    String nota;
    boolean flag;
    int y,x,c1,c2,c3,v;
    public Tecla(String nota,int v){
      this.nota=nota;
      c1=87;
      c2=35;
      c3=100;
      y=0;
      this.v=v;
      flag=true;
      switch((int)random(0,3.5)){
        case 0:
              x=10;
        break;
                case 1:
              x=120;
        break;
                case 2:
              x=230;
        break;
                case 3:
              x=340;
        break;
      }

    }
    
  void move(){
   fill(c1,c2,c3);
  rect(x,y,90,100,0);
  y+=v;
    

  }
  
  int getY(){
  return y;
  
  }
    int getX(){
  return x;
  
  }
  
  
  String getSonido(){
    return nota;
  
  }
  
  void setColor(int a,int b,int c){
    if(flag){
      c1=a;
      c2=b;
      c3=c;
      flag=false;
    }
  }
}
