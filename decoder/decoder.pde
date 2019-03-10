int col ;
int counter = 0;
String[] values ;
String line;
PImage img;
int wd;
int hg;
int[] colorTable;
BufferedReader input;
void setup() {
  String widthe = "512";
  String heighte = "512" ;
  //size(512, 512);
  fullScreen();
  surface.setResizable(true);
  input = createReader("code.txt");
  for(int i = 0 ; i < 2 ;i++){  
    try {
      line = input.readLine();
    }
    catch(IOException e) {
      e.printStackTrace(); 
      line = null;
    }
    if (line == null ) {
      print("The size of the image is invalid, exiting...");
      exit();
    } else {
        if(i==0) widthe = line;
        else heighte = line;
    }
  }
  try {
    wd = Integer.parseInt(widthe);
    hg = Integer.parseInt(heighte);
  }
  catch(NumberFormatException e){
      print("The size of the image is invalid, exiting..."); 
      exit();
  }
  surface.setSize(wd,hg);
}
void draw() {
  int pos=0;
  loadPixels();
  while (true) {
    try {
      line = input.readLine();
    } 
    catch(IOException e) {
      e.printStackTrace(); 
      line = null;
    }
    if (line == null ) {
      break;
    } else {
      if (unhex(line.substring(0,1)) == 8) {
        int value;
        value = unhex(line.substring(1, 6));
        if (unhex(line.substring(7, 9)) == 255) {
          int oldpos = pos;
          while (pos < oldpos+value) {
            color c = color(255, 255, 255);
            pixels[pos] = c;
            pos ++;
          }
        } else if (unhex(line.substring(7, 9)) == 0) {
          int oldpos = pos;
          while (pos < oldpos + value) {
            color c = color(0, 0, 0);
            pixels[pos] = c;
            pos ++;
          }
        } else {
          print("error in code file, unvalid characters ");
          exit();
        }
      } else if (unhex(line.substring(0,1)) == 0) {
        int value;
        value = unhex (line.substring(1, 6));
        int oldpos = pos;
        int i = 6;
        while (pos < oldpos + value) {
          if (unhex(line.substring(i+1, i+3)) == 255) {
            color c = color(255, 255, 255);
            pixels[pos] = c;
          } else if (unhex(line.substring(i+1, i+3)) == 0) {
            color c = color(0, 0, 0);
            pixels[pos] = c;
          } else {
            print("error in code file, unvalid characters ");
          }
          pos ++;
          i += 3;
        }
      }
    }
  }
  updatePixels();
  noLoop();  
}