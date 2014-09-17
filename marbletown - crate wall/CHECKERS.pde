int movecounter = 0;

class Checkers {
  
  Checkers() {
  }
  
  void checker() {
     pushMatrix();
     translate(-80, -20);
    for(int i = 0; i< 1420; i+=160){
          for(int f = 0; f< 820; f+=160){
            fill(255,200,100);
            noStroke();
            rect(i+movecounter, f+movecounter, 80, 80);
      rect(i+80+movecounter, f-80+movecounter, 80, 80);
          }
    }
    popMatrix();
    if (movecounter <= 80) {
     movecounter+=2;
    }
    else {
     movecounter=1;
    }
  }
}

