void main(){

  var map1 = {

    'first' : 10,
    'second' : 20,
    'third' : 30
  };

  print(map1);

  print('Another map:');

  var map2 = Map<int, String>();
  map2[1200] = 'Dhaka';
  map2[1900] = 'Tangail';
  map2[1342] = 'Savar';

  print(map2);
}