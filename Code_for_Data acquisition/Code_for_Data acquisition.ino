int data[250]; 
int count;
void setup(){
    Serial.begin(9600);
  
}
void loop() {

  

 for (count=0;count<250;count++)
 {
    data[count]=analogRead(A0);
    Serial.println(data[count]);
 
    


  }
}
