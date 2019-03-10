
// THERE IS AN ERROR !!!!! , IT COUNTS 2 same pixels as if they were 3, treat the case where no pixel is repeated 3 times or more

int col ;
int counter = 0;
int[] colorTable;
String value ;
PImage img;
PrintWriter output;
void setup() {
  img = loadImage("test6.jpg");
  colorTable = new int [img.width * img.height];
  img.loadPixels();
  fullScreen();
  for (int i= 0; i < img.height; i ++) {  // drawing the b/w picture 
    for (int j = 0; j < img.width; j++) {
      colorTable[j + i*img.width] = getColor(j + i * img.width);
    }
    }
    output = createWriter("code.txt");
    output.println(img.width);
    output.println(img.height);    
}
int getColor(int loc){
 if (img.pixels[loc] < color (125) ){ return 0;}
 else if (img.pixels[loc] >= color (125)){ return 255;}
 else { print("not black and white, exiting..."); exit();}
 return(col);
 }
void draw() {
  loadPixels();
  delay(1000);
  int diffSucc, bSucc, wSucc;
  int k , diff;
  boolean hexPrinted = false;
  diffSucc = bSucc = wSucc = 0;
  for (int i=0; i<img.width*img.height; i++) {
    hexPrinted = false;
    if (bSucc != 3 && wSucc != 3) {
      diffSucc++;
      //print(diffSucc);
      if (colorTable[i] == 0) { // wSucc successeur noirs , bSucc successeurs blancs, diffSucc Successeurs différents 
        wSucc = 0;
        bSucc++;
      } else {
        bSucc =0;
        wSucc++;
      }
    }
    if (bSucc == 3) {
      diff = (i-2) - (i -(diffSucc -1));       
      for (k = i - (diffSucc-1); k < i - 2; k++) {
          if (!hexPrinted) {  
            value = binary(diff,23);
            diff =  unbinary(value);
            print("(",hex(diff,6),"H) "); 
            output.print(hex(diff,6) + " ");
            hexPrinted = true;
          }        
        if (colorTable[k] == 0){if( k == i-3 ) {print("00H"); output.println("00");} else {print("00H "); output.print("00 ");}}
        else {if( k == i-3 ) {print("FFH "); output.println("FF");} else {print("FFH "); output.print("FF ");}}
      }
      diffSucc = 0;
      bSucc = 0;
      i=i-2;
      while (i < img.width*img.height && colorTable[i] == 0) {
        bSucc++;
        i++;
      }
      i--;
      print("(",hex(bSucc+8388608,6),"H) ");
      output.print(hex(bSucc+8388608,6) + " ");
      output.println("00");
      print("00H ");
      bSucc = 0;
    }
    if (wSucc == 3) {
      diff = (i-2) - (i -(diffSucc -1)); 
      for (k = i - (diffSucc-1); k < i - 2; k++) {
        if (!hexPrinted) { 
          value = binary(diff,23);
          diff = unbinary(value);
          print("(",hex(diff,6),"H) ");
          output.print(hex(diff,6) + " ");
          hexPrinted = true;
        }
        if (colorTable[k] == 0){if( k == i-3 ) {print("00H"); output.println("00");} else {print("00H "); output.print("00 ");}}
        else {if( k == i-3 ) {print("FFH"); output.println("FF");} else {print("FFH "); output.print("FF ");}}
        }
      diffSucc = 0;
      wSucc = 0;
      i=i-2;
      while (i < img.width*img.height && colorTable[i] == 255) {
        wSucc++;
        i++;
      }
      i--;
      print("(",hex(wSucc+8388608,6),"H) ");
      output.print(hex(wSucc+8388608,6)+" ");
      output.println("FF");
      print("FFH ");
      wSucc=0;
    }
/*    if(diffSucc != 0){ // à la fin d'image
           diff = (i-2) - (i -(diffSucc -1)); 
      for (k = i - (diffSucc-1); k < i - 2; k++) {
        if (!hexPrinted) { 
          value = binary(diff,23);
          diff = unbinary(value);
          print("(",hex(diff,6),"H) ");
          output.print(hex(diff,6) + " ");
          hexPrinted = true;
        }
        if (colorTable[k] == 0){if( k == i-3 ) {print("00H"); output.println("00");} else {print("00H "); output.print("00 ");}}
        else {if( k == i-3 ) {print("FFH"); output.println("FF");} else {print("FFH "); output.print("FF ");}}
        } 
        diffSucc = 0;
    }*/
  }
  delay(1000);
  output.close();
  exit();
  noLoop();
}