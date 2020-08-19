
////////////////////////////// glawLetters //////////////////////////////
/////////////////////////////////////////////////////////////////////////
////////////////////////// MADE BY PATY LOPEZ ///////////////////////////

import processing.sound.*;

int x[] = new int[100];
int y[] = new int[100];
char[] let = new char[100];
String bl;
float k=0;
int ingame=0, i=0, clr=130, score=0, level=0, w=0, vid=3, cn=0;

SoundFile a_error, a_main, a_score, a_slc, a_gomain;
PFont modeka;
PImage img_inicioanim, img_inicio, img_inicioletras, img_ingame, img_end;
PImage cor03, cor02, cor01, cor00;
PImage go_main, go_tria, go_hoyo, go_skull;


void setup() {
  size(1280,720);  bl="dw";
  
  modeka = createFont("Modeka.otf",30);
  //a_main = new SoundFile(this,"envm.mp3");
  a_score = new SoundFile(this,"score.mp3");
  //a_error = new SoundFile(this,"a_error.wav");
  //a_slc = new SoundFile(this,"a_slc.wav");
  //a_gomain = new SoundFile(this,"go_main.wav");
  //a_main.play();

  // Generating the random letters
  for (int i=0; i<10; i++) {
    x[i] = (int)random(20,1260);
    y[i] = 100;
    let[i] = (char)random(65,90);
  }
  
  // Images
  img_inicio = loadImage("inicio.png");
  img_inicioletras = loadImage("inicioletras.png");
  img_ingame = loadImage("ingame.png");
  img_end = loadImage("end.png");
  img_inicioanim = loadImage("go_hoyo.png");      imageMode(CENTER);

  go_main = loadImage("go_main.png");
  go_tria = loadImage("go_tria.png");
  go_skull = loadImage("go_skull.png");

  cor03 = loadImage("cor03.png");
  cor02 = loadImage("cor02.png");
  cor01 = loadImage("cor01.png");
  cor00 = loadImage("cor00.png");

}

void draw() {
    
  // Game
  if(ingame==1) {
    background(img_ingame);
    fill(255);
    
    // Levels
    if (score>=0 && score<=9)        level=1;
    else if (score>=10 && score<=19) level=2;
    else if (score>=20 && score<=29) level=3;
    else if (score>=30 && score<=39) level=4;
    else if (score>=40 && score<=49) level=5;
    else if (score>=50 && score<=59) level=6;
    else if (score>=60 && score<=69) level=7;
    else if (score>=70 && score<=79) level=8;
    else if (score>=80 && score<=89) level=9;
    else if (score>=90 && score<=99) level=10;
    else if (score>=100) ingame=3;
    
    // Scoreboard
    textSize(36);
    text(score,140,60);
    text(level,410,60);

    if(vid==3)       image(cor03,1165,40);
    else if(vid==2)  image(cor02,1165,40);
    else if(vid==1)  image(cor01,1165,40);
    else             ingame=2;
    
      // Letter cycle
      for (int lcon=0; lcon<level; lcon++) {
        if (y[w+lcon]<height) {
          if (w!=10) {
            text(let[w+lcon], x[w+lcon], y[w+lcon]);
            y[w+lcon]+=2;
          } else w=0;
        }
        else {
          vid--;
          //a_error.play();
          y[w+lcon]=(int)random(0,100);
          w++;
        }
      }
      
  }
  
  // Menu
  else if(ingame==0) {
    background(0);
      translate(width/2, height/2);    rotate(k);
      image(img_inicioanim,0,0);
      resetMatrix();  k+=0.003;
    image(img_inicioletras,width/2, height/2);
    
    if(bl=="dw") {
      fill(clr);
      textFont(modeka);
      text("PRESS ENTER TO START",530,520);  clr+=3;
    }
    else {
      fill(clr);
      textFont(modeka);
      text("PRESS ENTER TO START",530,520);  clr-=3;
    }
    
    if(clr>=253)      bl = "up";
    else if(clr<=130) bl = "dw";
    
  }
    
    // GAME OVER
    else if (ingame==2) {
      image(go_main,width/2,height/2);
      fill(255);
      textSize(36);
      text(score,424,436);
      text(level,900,436);
      image(go_skull,width/2,120);
      image(cor00,1165,40);
      
      if(bl=="dw") {
        fill(clr);
        textFont(modeka);
        text("PLAY AGAIN?",585,530);  clr+=3;
      }
      else {
        fill(clr);
        textFont(modeka);
        text("PLAY AGAIN?",585,530);  clr-=3;
      }
      if(clr>=253)      bl = "up";
      else if(clr<=130) bl = "dw";
      
      if (mouseX>=510 && mouseX<=560 && mouseY>=575 && mouseY<=605) {
        image(go_tria,533,575);
      } 
      else if(mouseX>=720 && mouseX<=770 && mouseY>=575 && mouseY<=605) {
        image(go_tria,743,575);
      }
      
    }
    
    // "HAS SUPERADO EL JUEGO"
    else if(ingame==3) {
      image(img_end,width/2,height/2);
      fill(255);
      textSize(36);
      
      if(bl=="dw") {
        fill(clr);
        textFont(modeka);
        text("PLAY AGAIN?",585,530);  clr+=3;
      }
      else {
        fill(clr);
        textFont(modeka);
        text("PLAY AGAIN?",585,530);  clr-=3;
      }
      if(clr>=253)      bl = "up";
      else if(clr<=130) bl = "dw";
      
      if (mouseX>=510 && mouseX<=560 && mouseY>=575 && mouseY<=605) {
        image(go_tria,533,575);
      } 
      else if(mouseX>=720 && mouseX<=770 && mouseY>=575 && mouseY<=605) {
        image(go_tria,743,575);
      }
    }
  }

// Keys
void keyPressed() {
  // Start of the game
  if(key==ENTER) {
    //a_slc.play();
    ingame=1;
  }
  
  // Disappearance of letters and increase of score
  for (int lcon=0; lcon<level; lcon++) {
    if(key==(char)(let[w+lcon]+32)) {
      a_score.play();
      score++;
      let[w+lcon]=(char)random(65,90);  
      y[w+lcon]=(char)random(60,100);
      x[w+lcon] = (int)random(20,1260);
    }
  }
  
}

void mouseClicked() {
  // Configuracion del "YES" y "NO"
  if(mouseX>=510 && mouseX<=560 && mouseY>=575 && mouseY<=605) {
    //a_slc.play();
    vid=3;  ingame=1;
    level=0;  score=0;  w=0;
  }
  else if(mouseX>=720 && mouseX<=770 && mouseY>=575 && mouseY<=605) {
    //a_slc.play();
    vid=3;  ingame=0;
    level=0;  score=0; 
  }
}


/////////////////////////////////////////////////////////////////////////
