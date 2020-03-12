import processing.serial.*;

int lf=10;
int value;
String myString = null;
Serial myPort;

Button on_button;  // the button
int clk=0;
void setup() {
  size(200, 200);
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.clear();
  myString = myPort.readStringUntil(lf);
  myString = null;
  print(myString);
  //creating button class object to add UID
  //on_button = new Button("Add UID", 10, 10, 70, 30);
  //on_button.addUserBtn();
}
void draw() {
  //getting data from serial port when data coming
  while (myPort.available()>0) {
    myString = myPort.readStringUntil(lf);
    print(myString);
    if (myString!=null) {
      myString = trim(myString);
    }
    smooth();
  }
  //if string is not null
  if(clk<=0){
    if (myString !=null) {
      String []myStringAr = split(myString, " ");
      String finalString = "method=getRFIDAttendanceApi&uid="+join(myStringAr, "");
      validateUser(finalString);
        on_button = new Button("Value Read Success", 30, 10, 160, 30);
        on_button.addUserBtn();
    }
  }else{
    
  }
  myString = null;
  // draw the button in the window
  
}
// mouse button clicked
void mousePressed()
{
  if (on_button.MouseIsOver()) {
    // print some text to the console pane if the button is clicked
    print("User addition mode is on to stop press stop");
    if(clk==1)
    on_button.stopBtn();
    println(clk++);
  }
}
//call to check wheater uid user is valid or not 
void validateUser(String uid) {
  delay(1000);
  if (uid!=null) {
    uid = trim(uid);

    // finalUid = finalUid+"A";
    //println(uid);
    String url = "http://localhost/attendanceSystem/callApi.php?"+uid;
    println(url);
    try {
      String[] lines = loadStrings(url);

      //println("there are " + lines.length + " lines");
      for (int i = 0; i < lines.length; i++) {
        println(lines[i]);
      }
    }
    catch(Exception e) {
      println("Something Unexpected Happened Please try after Sometime!");
    }
    //println(lines);
  }
}
