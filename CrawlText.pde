import processing.sound.*;

String str = "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Honda Empire.\n\nDuring the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the MINI VAN, an armored space station with enough power to destroy an entire planet.\n\nPursued by the Empire's sinister agents, Princess Ava races home aboard her bicycle, custodian of the stolen plans that can save her people and restore freedom to the galaxy...."; 
float yCurr = 700;

void setup() {
  size(1000, 800, P3D);

  textSize(48);
  textAlign(CENTER);
  textLeading(textAscent()+4);
  
  str = createLineBreaks(str, 2*width/3);
  
  SoundFile file = new SoundFile(this, "StarWarsTheme.mp3");
  file.play();
  file.rate(0.50);  
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotateX(PI/3.0);
  fill(255, 255, 0);
  text(str, 0, yCurr);
  yCurr -= 0.5;
}


// From https://forum.processing.org/two/discussion/3645/get-height-of-wrapping-text
public String createLineBreaks(String str, float maxWidth) {
 
    // Remove unnecessary spaces
    // and add (unix) linebreak characters if line length exceeds maxWidth
    StringBuilder strBuffer = new StringBuilder(str.length());
    boolean firstSpace = false;
    int lastSpace = -1, iB = 0;
    float currentWidth = 0, wordWidth = 0;
    for(int i = 0, n = str.length(); i < n; i++) {
        char c = str.charAt(i);
        if(c == ' ') { // If this character is a space
            if(firstSpace) { // If this space is the first space in a row
                if(currentWidth > maxWidth && lastSpace > -1) {
                    strBuffer.setCharAt(lastSpace, (char)10);
                    currentWidth -= wordWidth;
                }
                currentWidth += textWidth(c);
                wordWidth = currentWidth;
                lastSpace = iB;
                strBuffer.append(c);
                firstSpace = false;
                iB++;
            }
        } else { // If character is no space
            currentWidth += textWidth(c);
            strBuffer.append(c);
            firstSpace = true;
            iB++;
        }
    }
    if(currentWidth > maxWidth && lastSpace > -1) // If last line still exceeds maxWidth
        strBuffer.setCharAt(lastSpace, (char)10);
 
    // Return string
    return strBuffer.toString();

}