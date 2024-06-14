#include <DHT.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
#include "RTClib.h"
#include <SoftwareSerial.h>

RTC_DS3231 rtc;


const int lcdColumns = 16;
const int lcdRows = 2;
LiquidCrystal_I2C lcd(0x27, 16, 2);

#define dhtpin 7
//define dht type
#define DHTTYPE DHT11
#define BT_RX 2
#define BT_TX 3
DHT dht(dhtpin,DHTTYPE);
SoftwareSerial BTSerial(BT_RX, BT_TX);
String messagebuffer = "";
String message = "";
void setup() {
  // put your setup code here, to run once:
  pinMode(BT_RX, INPUT);
  pinMode(BT_TX, OUTPUT);
  BTSerial.begin(9600);

    dht.begin();
    Serial.begin(9600);
    lcd.init();   
    // lcd.begin(16,2);                        // Initialize the LCD
    // lcd.clear(); 
    lcd.backlight();
    if (!rtc.begin()) {
    Serial.println("Couldn't find RTC");
    while (1);
  }

  if (rtc.lostPower()) {
    Serial.println("RTC lost power, let's set the time!");
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  }
  
}

void loop() {
  // put your main code here, to run repeatedly:
  
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  DateTime now = rtc.now();
  Serial.print("temperature: ");
  Serial.println(temperature);

  if (isnan(humidity) || isnan(temperature)){
    Serial.println("failed to read from DHT sensor");
    return;
  }


  lcd.setCursor(0, 0); // Set cursor to the first column of the first row
  lcd.print(now.day(),DEC);
  lcd.print("/");
  lcd.print(now.month(),DEC);
  lcd.print("/");
  lcd.print(now.year()%100,DEC);
  lcd.print(" ");
  lcd.print(now.hour(),DEC);
  lcd.print(":");
  lcd.print(now.minute(),DEC);
  lcd.print(":");
  lcd.print(now.second(),DEC);
  lcd.setCursor(0,1);
  lcd.print("temp: ");
  lcd.print(temperature);


  

  while (BTSerial.available() > 0) {
    
    char data = (char) BTSerial.read();
    Serial.println("the received app data is: "+ data);
    if(data = "success"){

    Serial.println("data recieved is "+data); 
    BTSerial.print(temperature);
    
    }
  }
  
}
