void main(){

  // var student1 = Student();
  // student1.id = 1718;
  // student1.name = 'Meherab Hossen';
  // print('${student1.id} and ${student1.name}');

  var student2 = Student(1850, 'Abdullah Apon');
  print('${student2.id} and ${student2.name}');

  var student3 = Student.CustomConstructor();
}

//Default constructor
class Student{

  int id =-1;
  String name = 'johny';
  
  //default constructor
  // Student(){

  //   print('Student constructor has been called.');
  // }

  //parameterized constructor

  Student(int id, String name){ //we can also use this.id and this.name here

    this.id = id; //here, this.id is the id in line 13 and id is in line 24
    this.name = name; //here, this.name is the name of line 14, name is the name in line 24
  }

  Student.CustomConstructor(){

    print('Custom constructor called');
  }
}
