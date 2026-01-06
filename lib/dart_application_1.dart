import 'dart:io';

int calculate() {
  return 42;
}

void main() {
  print('Which operation you want to do');
  print('1. Sum\n2. Sub\n3. Mul\n4. Div\n5. Mod');
  print('Select: ');
  int? selection = int.parse(stdin.readLineSync()!);
  int? num1, num2;
  print('Enter number 1: ');
  num1 = int.parse(stdin.readLineSync()
  !);
  print('Enter number 2: ');
  num2 = int.parse(stdin.readLineSync()
  !);
  
  int sum(int a, int b){
      int output = a + b;
      return output;
  }
  
  int sub(int a, int b){
      int output = a - b;
      return output;
  }
  
  int mul(int a , int b){
      int output = a * b;
      return output;
  }
  
  double div(int a, int b){
      double output = a / b;
      return output;
  }
  
  int mod(int a, int b){
      int output = a % b;
      return output;
  }
  
  switch(selection){
      case 1:
      int res = sum(num1, num2);
      print('Output: $res');
      break;
      case 2:
      int res = sub(num1, num2);
      print('Output: $res');
      break;
      case 3:
      int res = mul(num1, num2);
      print('Output: $res');
      break;
      case 4:
      double res = div(num1, num2);
      print('Output: $res');
      break;
      case 5:
      int res = mod(num1, num2);
      print('Output: $res');
      break;
  }
  
}