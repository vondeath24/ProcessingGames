import ddf.minim.*;

AudioPlayer song;
Minim minim;

Cat cat;


PImage [] nyan = new PImage[12];//loads the array image
PImage stars;
PImage startpage;
PImage gameover;

boolean once;

int wid = 500;
int rez = 20;
int score = 0;//var to keep track of the score
int m;
int i;
int w = 40;
int x = wid + w;

int gamestate= 1;//controls the pages

boolean jumping = false;//true false to see if the mouse is pressed
PVector gravity = new PVector(0, 0.5);//set's up the drop for the character
ArrayList<Pipe> pipes = new ArrayList<Pipe>();//makes a list so the pipes can return

void setup() {
  size(400, 800);

  minim = new Minim(this);
  song = minim.loadFile("nCatTheme.mp3");

  cat = new Cat();//calls cat class
  pipes.add(new Pipe());// calls the pipe class

  stars = loadImage("stars.jpg");//calls images
  startpage = loadImage("start.png");//calls images
  gameover = loadImage("gameOver.png");//calls images

  for (int m = 0; m < nyan.length; m++) {//loading the array of images
    nyan[m] = loadImage("n" + m + ".png");
  }
  nyan[m].resize(50, 75);
}

void draw() {
  background(stars);
  if (gamestate == 0) {//Game has begun
    song.play();
    if (frameCount % 75 == 0) {//makes pipes recur
      pipes.add(new Pipe());
    }
    if (mousePressed) {//click to make cat go up
      PVector up = new PVector(0, -5);
      cat.applyForce(up);
    }
    //displays the cat
    cat.update();
    cat.display();
    boolean safe = true;//collision

    //displays the pipes
    for (int i = pipes.size() - 1; i >= 0; i--) {
      Pipe p = pipes.get(i);
      p.update();
      if (p.hits(cat)) {
        p.display(true);
        safe = false;
      } else {
        p.display(false);
      }
      if (p.x < -p.w) {
        pipes.remove(i);
      }
    }
    if (safe) {
      score++;
    } else {
      score = 0;
    }

    fill(255, 0, 255);//score color
    textSize(64);
    text(score, width/2, 50);//location
    score = constrain(score, 0, score);
  } else if (gamestate == 3) {//game over screen
    imageMode(CENTER);
    image(gameover, width/2, height/2);
    if (keyPressed) {
      if (key == ' ') {
        for (int i = pipes.size() - 1; i >= 0; i--) {
          pipes.remove(i);
        } 
        gamestate =1;
        song.pause();
        song.rewind();
      }
    }
  }

  if (gamestate == 1) {//The startpage for our game
    imageMode(CENTER);
    image(startpage, width/2, height/2);

    if (mousePressed && once ==false) {
      gamestate = 0;
      once = true;
    } else {
      once = false;
    }
  }
}