character[] chars = new character[4];
character boss;
button[] butMove = new button[4];
int tCounter = 0;//Testing Purposes

void setup() {
  size(570,170);
  frameRate(24); //Testing purposes
  int[] damageCecil = {10, 20, 30, 40};
  chars[0] = new character("Cecil", 1000, 150, 100, damageCecil);
  int[] damageKain = {11, 21, 31, 41};
  chars[1] = new character("Kain", 1001, 151, 101, damageKain);
  int[] damageRosa = {12, 22, 32, 42};
  chars[2] = new character("Rosa", 1002, 152, 102, damageRosa);
  int[] damageRydia = {13, 23, 33, 43};
  chars[3] = new character("Rydia", 1003, 153, 103, damageRydia);
  for(int i=0; i<=3; i++) {
    butMove[i] = new button(chars[0].attackImage[i], (i%2)*285, (int(i/2))*85, 285, 85);
  }
  int[] damageBoss = {14, 24, 34, 44};
  boss = new character("Andy", 1000, 0, 0, damageBoss);
}

void draw() {  //Testing Purposes
  if(tCounter<=3) {
    for(int i=0; i<=3; i++) {
      butMove[i].drawButton();
    }
  } else {
    noStroke();
    rect(0,0,570,170);
  }
}

void mousePressed() {
  if(tCounter<=3) {
    for(int i=0; i<=3; i++) {
      if(butMove[i].over()) {
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
        butMove[i] = new button(chars[tCounter].attackImage[i], (i%2)*285, (int(i/2))*85, 285, 85);
      }
    } else {
      for(int i=0; i<=3; i++) {
        butMove[i] = new button(chars[0].attackImage[i], (i%2)*285, (int(i/2))*85, 285, 85);
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
    img = loadImage("Pictures\\" + inName + "-Status.gif");
    hp = inHP;
    maxHP = inHP;
    mp = inMP;
    maxMP = inMP;
    tp = inTP;
    maxTP = inTP;
    for(int i=0; i<=3; i++) {
      attackDamage[i] = damageList[i];
      if(i==0) {
        attackImage[i] = loadImage("Pictures\\atk.Default.png");
      } else if(i>=1) {
        attackImage[i] = loadImage("Pictures\\atk." + inName + i + ".png");
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