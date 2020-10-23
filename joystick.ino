void setup() {
  // put your setup code here, to run once:
  pinMode(2, INPUT);//SW pin(the click switch)
  Serial.begin(9600);
  digitalWrite(2, HIGH);
  

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(analogRead(A0));
  Serial.print(", ");
  Serial.print(analogRead(A1));
  Serial.print(", ");
  Serial.println(digitalRead(2));
  delay(100);


}
