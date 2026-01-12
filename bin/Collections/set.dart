/*
complex theory
unordered index, so we can't access index like list
different output
unique elements
*/

void main(){

  Set name = {'meherab', 'hossen', 'nishat'};
  print('Initial Set: $name');
  name.add('_ ');
  name.add('Daffodil');
  name.add('International');
  name.add('Universiity');

  print('Set after adding: $name');
  print('Runtime type: ${name.runtimeType}');
}