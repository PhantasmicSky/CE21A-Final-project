character[] chars = new character[4];//
character boss;//
button[] butMove = new button[4];//
int tCounter = 0;//
PImage bg[] = new PImage[5];
PImage menubg,screenelem,cecil,kain,rosa,lydia;
PImage trial[] = new PImage[5];
PImage mobs[] = new PImage[9];
PFont uifont, titlefont, statfont;
int screenstate=0;
int sephhp=100000;
//int cecilstat[]={1000,1000,1000};
//int maxcecilstat[]={1000,1000,1000};
void setup()
{
  int[] damageCecil = {10, 20, 30, 40};//
  chars[0] = new character("Cecil", 1000, 150, 100, damageCecil);//
  int[] damageKain = {11, 21, 31, 41};//
  chars[1] = new character("Kain", 1001, 151, 101, damageKain);//
  int[] damageRosa = {12, 22, 32, 42};//
  chars[2] = new character("Rosa", 1002, 152, 102, damageRosa);//
  int[] damageRydia = {13, 23, 33, 43};//
  chars[3] = new character("Rydia", 1003, 153, 103, damageRydia);//
  for(int i=0; i<=3; i++) {//
    butMove[i] = new button(chars[0].attackImage[i], (i%2)*285+15, (int(i/2))*85+415, 285, 85);//
  }//
  int[] damageBoss = {14, 24, 34, 44};//
  boss = new character("Andy", 1000, 0, 0, damageBoss);//
  size (800,600);
  uifont = createFont ("Felix Titling",30);
  titlefont= createFont ("Felix Titling",72);
  statfont=createFont ("Meiryo",12);
  for (int i=1;i<5;i++)
  {
  trial[i]=loadImage ("image"+i+".png");
  }
  for (int i=1;i<5;i++)
  {
  bg[i-1]=loadImage ("bg"+i+".gif");
  bg[i-1].resize(600,400);  
  }
  menubg=loadImage("menubg.png");
  menubg.resize (800,600);
  screenelem=loadImage("SIDEUI.png");
  cecil=loadImage("Cecil1-Walk.gif");
  kain=loadImage("Kain-Walk.gif");
  rosa=loadImage("Rosa-Walk.gif");
  lydia=loadImage("Rydia2-Walk.gif");
  mobs[0]=loadImage("Doom or Sephirot.gif");
}

void draw()
{
  if (screenstate==0||screenstate==1)
  {
  background(0);
  image (menubg,0,0);
  }
  if (screenstate==0) //main menu
  {
  rectMode(CORNER);
  textAlign(CENTER);
  fill (0,0,200);
  textFont(titlefont);
  text("EORZEAN TRIALS", 0,100,800,172);
  rectMode(CORNERS);
  fill(255);
  rect(350,475,450,525);
  textFont(uifont);
  rectMode(CORNER);
  fill(0);
  text("START",400,510);
  } 
  else if (screenstate==1) // trial select
  {
    textAlign(CENTER);
    textFont(titlefont);
    text("SELECT A TRIAL",0,20,800,172);
    textFont(uifont);
    textAlign(LEFT);
    image (trial[1],100,100);
    text("Leviathan (EASY)",300,100,800,130);
    image (trial[2],100,220);
    text("Ramuh (NORMAL)",300,220,800,250);
    image (trial[3],100,340);
    text("Shiva (HARD)",300,340,800,370);
    image (trial[4],100,460);
    text("Sephirot (EXTREME)",300,460,800,490);
  }
  else if (screenstate==2) //sephirot(to be removed)
  {
    image(bg[0],0,0);
    fill(0);
    text("I AM THE END AND THE BEGINNING!",100,400);
    rectMode(CORNER);
    fill(102);
    rect(600,0,200,400);
    rect(0,400,600,200);
    image(screenelem,615,15);
    if (boss.hp > 0)
    {
     image (mobs[0],100,84); 
    }
    if (chars[0].hp >0)
    {
      image (cecil,450,152);
    }
    if (chars[1].hp >0)
    {
      image (kain,450,214);
    }
    if (chars[2].hp > 0)
    {
      image (rosa,450,276);
    }
    if (chars[3].hp > 0)
    {
      image (lydia,450,338);
    }
    
    charstatus();
    if(tCounter<=3) {//
    for(int i=0; i<=3; i++) {//
      butMove[i].drawButton();//
    }//
  } else {//
    noStroke();//
    rect(15,415,570,170);//
  }//
  }
}

void mouseClicked()
{
  if (screenstate==0 && mouseX>350 && mouseX<450 && mouseY>475 && mouseY<525)
  {
    screenstate=1;
  }
  else if (screenstate==1)
  {
    if (mouseX>100 && mouseY>460 && mouseX<476 && mouseY<580) //initialize sephirot battle
    {
     screenstate=2; 
    }
  }
  else if (screenstate==2) //everything inside screenstate==2 is martin's code
  {
    if(tCounter<=3) {
    for(int i=0; i<=3; i++) {
      if(butMove[i].over()) {
        chars[tCounter].attackDamage[i]=int(random(20,75));
        println(chars[tCounter].attackDamage[i]);
        boss.damage(chars[tCounter].attackDamage[i]);
        if(boss.isAlive()) {
          println(boss.name + ": " + boss.hp);
        } else {
          println(boss.name + " is dead.");
        }
      }
    }
    tCounter++;
    if(tCounter<=3) {
      for(int i=0; i<=3; i++) {
        butMove[i] = new button(chars[tCounter].attackImage[i], (i%2)*285+15, (int(i/2))*85+415, 285, 85);
      }
    } else {
      for(int i=0; i<=3; i++) {
        butMove[i] = new button(chars[0].attackImage[i], (i%2)*285+15, (int(i/2))*85+415, 285, 85);
      }
    }
  } else {
    int target = int(random(0,3));
    chars[target].damage(boss.attackDamage[int(random(0,3))]);
    if(chars[target].isAlive()) {
      println(chars[target].name + ": " + chars[target].hp);
    } else {
      println(chars[target].name + " is dead.");
    }
    tCounter = 0;
  }
  }
}

void charstatus() //displays the current HP, MP, TP of each character
{
  fill(0,0,0);
  textFont(statfont);
  textAlign(LEFT);
  text(chars[0].hp +"/"+chars[0].maxHP,708,77);
  text(chars[1].hp +"/"+chars[1].maxHP,708,141);
  text(chars[2].hp +"/"+chars[2].maxHP,708,205);
  text(chars[3].hp +"/"+chars[3].maxHP,708,270);
  text(chars[0].mp +"/"+chars[0].maxMP,708,92);
  text(chars[1].mp +"/"+chars[1].maxMP,708,156);
  text(chars[2].mp +"/"+chars[2].maxMP,708,220);
  text(chars[3].mp +"/"+chars[3].maxMP,708,285);
  text(chars[0].tp +"/"+chars[0].maxTP,708,107);
  text(chars[1].tp +"/"+chars[1].maxTP,708,171);
  text(chars[2].tp +"/"+chars[2].maxTP,708,235);
  text(chars[3].tp +"/"+chars[3].maxTP,708,300);
}

//everything from this point is martin's code

class unit {
  String name, fileName;
  int hp, maxHP, dot;
  int[] attackDamage = new int[4];
  PImage img;
  
  /*unit(String inName, int inHP, int damageList[]) {
    name = inName;
    hp = inHP;
    maxHP = inHP;
    for(int i=0; i<=3; i++) {
      attackDamage[i] = damageList[i];
    }
  }*/
  
  void damage(int dmg) {
    hp -= dmg;
  }
  
  boolean isAlive() {
    if(hp<=0) {
      return false;
    } else {
      return true;
    }
  }
}

class character extends unit {
  int mp, tp, maxMP, maxTP;
  //String[] attackImageName = new String[4];
  PImage[] attackImage = new PImage[4];
  
  character(String inName, int inHP, int inMP, int inTP, int[] damageList) {
    name = inName;
    img = loadImage(inName + "-Status.gif");
    hp = inHP;
    maxHP = inHP;
    mp = inMP;
    maxMP = inMP;
    tp = inTP;
    maxTP = inTP;
    for(int i=0; i<=3; i++) {
      attackDamage[i] = damageList[i];
      if(i==0) {
        attackImage[i] = loadImage("atk.Default.png");
      } else if(i>=1) {
        attackImage[i] = loadImage("atk." + inName + i + ".png");
      }
    }
  }
}

class button {
  int butX, butY, butWidth, butHeight;
  PImage butImage;
  
  button(PImage inImg, int inX, int inY, int inWidth, int inHeight) {
    butX = inX;
    butY = inY;
    butWidth = inWidth;
    butHeight = inHeight;
    butImage = inImg;
  }
  
  boolean over() {
    if(mouseX>=butX && mouseX<=butX+butWidth && mouseY>=butY && mouseY<=butY+butHeight) {
      return true;
    } else {
      return false;
    }
  }
  
  void drawButton() {
    image(butImage, butX, butY, butWidth, butHeight);
  }
}