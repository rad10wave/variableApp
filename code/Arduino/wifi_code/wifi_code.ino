#include "HX711.h"
#include <stdlib.h>
#include<SoftwareSerial.h>
SoftwareSerial nodemcu(7, 8); // nodemcu module connected here
#define DOUT  3
#define CLK  2
HX711 scale(DOUT, CLK);

String myString; 
String cmessage; // complete message
char buff[10];
float weight; 
float calibration_factor = -176640;   //-119650 is working too
void setup() {
  Serial.begin(9600);
  nodemcu.begin(9600);
  scale.set_scale();
  scale.tare(); //Reset the scale to 0
  long zero_factor = scale.read_average(); //Get a baseline reading 
}
void loop() {
scale.set_scale(calibration_factor); //Adjust to this calibration factor
weight = scale.get_units(5); //5
myString = dtostrf(weight, 3, 2, buff);
cmessage = cmessage+ myString; 
nodemcu.println(cmessage);
Serial.println(cmessage); 
cmessage = "";
delay(100);
  
}
