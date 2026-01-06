void main(){

  var numbers = [10, 20, 30, 40];
  print(numbers);
  //adding single item
  numbers.add(50);
  print('List after adding a number: $numbers');

  //to copy one list item to another
  var copy = [];
  copy.addAll(numbers);
  print('Copied list: $copy');

  //to insert in a specific position
  numbers.insert(3, 100);
  print('After inserting data in third position, the list is: $numbers');

  //to insert multiple data after a specific position
  var age = [21,22,24,27,30];
  numbers.insertAll(3, age);
  print('After inserting data from third position: $numbers');

  //update item
  numbers[2] = 99999;
  print('Updated items: $numbers');

  //replace multiple items
  numbers.replaceRange(2, 5, [1,2,3,4]);
  print('Multiple replacement: $numbers');

  //remove multiple items
  numbers.removeRange(2, 5);
  print('List after removing: $numbers');

  //remove specific item
  numbers.removeAt(2);
  print('After removing specific item, list: $numbers');

  //remove last element
  numbers.removeLast();
  print('After removing last element, list: $numbers');

  print('Length: ${numbers.length}');
  print('Reversed: ${numbers.reversed}');
  print('First: ${numbers.first}');
  print('Last: ${numbers.last}');
  print('Is empty: ${numbers.isEmpty}');
  print('Is not empty: ${numbers.isNotEmpty}');
  print('Element at position 3: ${numbers.elementAt(2)}');

}