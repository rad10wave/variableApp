#include <SerialESP8266wifi.h>
#include <SoftwareSerial.h>
#include <SimpleTimer.h>
#include <FirebaseArduino.h>
#define FIREBASE_HOST "xxx"
#define FIREBASE_AUTH "xxx"
char ssid[] = "RAHUL 5G";
char pass[] = "123QWERTY";

 
SimpleTimer timer;
 
String myString; 
char rdata;
String weight;
 
int firstVal;  

void setup()
{
  // Debug console  Serial.begin(9600);
    timer.setInterval(1000L,sensorvalue1); 
 
}
 
void loop()
{
 

   
  if (Serial.available() > 0 ) 
  {
    rdata = Serial.read(); 
    myString = myString+ rdata; 
   // Serial.print(rdata);
    if( rdata == '\n')
    {
Serial.println(myString);
// new code
weight = getValue(myString, ',', 0);
 
  myString = "";
// end new code
    }
  }
 
}
 

 
 
String getValue(String data, char separator, int index)
{
    int found = 0;
    int strIndex[] = { 0, -1 };
    int maxIndex = data.length() - 1;
 
    for (int i = 0; i <= maxIndex && found <= index; i++) {
        if (data.charAt(i) == separator || i == maxIndex) {
            found++;
            strIndex[0] = strIndex[1] + 1;
            strIndex[1] = (i == maxIndex) ? i+1 : i;
        }
    }
    return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}
