// parameters
const int matrix_cols = 3;
const int matrix_rows = 2;
const int s_baudRate = 28800;

const int dPortRows[matrix_rows] = {53,52};
const int pwmPortCols[matrix_cols] = {2,3,4};

// data
const int matrix_numel = matrix_cols*matrix_rows;
byte incomingBytes[matrix_numel]; // for incoming serial data
byte map2d[matrix_rows][matrix_cols];

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_BUILTIN,OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);

  // initialize the serial communications:
  Serial.begin(s_baudRate);

  // initialize the serial communications:
  Serial1.begin(s_baudRate);

  // init ports
  for(int i=0; i<matrix_cols; i++)
    pinMode(pwmPortCols[i],OUTPUT);

  for(int i=0; i<matrix_rows; i++)
    pinMode(dPortRows[i],OUTPUT);  

  for(int i=0; i<matrix_numel; i++)
    incomingBytes[i] = 0;
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available() >= matrix_numel) {
    // read ffrom matlab app
    Serial.readBytes(incomingBytes, matrix_numel);
    // write to pc consol
    //Serial1.write(incomingBytes, matrix_numel);

    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(1000);                       // wait for a second
    digitalWrite(LED_BUILTIN, LOW); 
  

//  memcpy(map2d, incomingBytes, sizeof(incomingBytes[0])*matrix_numel);
//  for(int i=0; i<matrix_rows; i++) {
//    for(int j=0; j<matrix_cols; j++) {
//      Serial1.print(map2d[i][j],DEC);
//    }
//  }

for(int i=0; i<matrix_numel; i++) {
Serial1.print(incomingBytes[i], DEC);
Serial1.print('-');
}
  
  activeMatrix();
  }
}



void activeMatrix( void ) {
  bool activeRow = false;
  
  for(int i=0; i<matrix_rows; i++) {
    // verifica si la fila debe ser activada
    for(int j=0; j<matrix_cols; j++) {
      if (map2d[i][j] > 0) {
        activeRow = true;
        break;
      }
    }

    if (activeRow) {
      digitalWrite(dPortRows[i], HIGH);      
      for(int j=0; j<matrix_cols; j++) {
        if (map2d[i][j] > 0) {
          analogWrite(pwmPortCols[j], map2d[i][j]);
        } else{
          analogWrite(pwmPortCols[j], 0);
        }
      }
    } else {
      digitalWrite(dPortRows[i], LOW);
    }

    activeRow = false;
  }
}

