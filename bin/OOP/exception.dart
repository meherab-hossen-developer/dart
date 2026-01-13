void main(){

  print('When you know the exception to be thrown, use \'on\' clause');
  try{
    int result = 12 ~/ 0;
    print('The result is $result');
  } on IntegerDivisionByZeroException{
    print('Cananot divide by Zero');
  }

  print('When you do not know the exception use \'catch\' clause');
  try{
    int result = 12 ~/ 0;
    print('The result is $result');
  } catch(e) {
    print('The exception thrown is $e');
  }

  print('Using STACK TRACE to know the events occured before Exception was thrown');
  try{
    int result = 12 ~/ 0;
    print('The result is $result');
  } catch(e, s) {
    print('The exception thrown is $e');
    print('STACK TRACE: \n$s');
  }

  print('Whether there is an Exception or not, Finally clause is always Exacuted');
  try{
    int result = 12 ~/ 0;
    print('The result is $result');
  } catch (e) {
    print('The exception thrown is $e');
  }finally{
    print('This is FINALLY Clause and is always executed');
  }
}