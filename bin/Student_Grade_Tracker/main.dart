import 'dart:io';

// Abstract class - Must be implemented by subclasses
abstract class Gradable {
  double calculateAverage();
  String getLetterGrade();
}

// Interface - Classes must implement all methods
abstract class Printable {
  void displayInfo();
  String getFormattedInfo();
}

// Mixin - Can be mixed into classes
mixin AttendanceMixin {
  int attendedClasses = 0;
  int totalClasses = 0;

  void markAttendance(bool present) {
    totalClasses++;
    if (present) {
      attendedClasses++;
    }
  }

  double getAttendancePercentage() {
    if (totalClasses == 0) return 0.0;
    return (attendedClasses / totalClasses) * 100;
  }

  String getAttendanceStatus() {
    double percentage = getAttendancePercentage();
    if (percentage >= 75) return 'Good';
    if (percentage >= 50) return 'Average';
    return 'Poor';
  }
}

// Base class for Person
class Person {
  String name;
  String id;
  String? email; // Null safety - optional field

  // Constructor with named parameters
  Person({required this.name, required this.id, this.email});

  // Named constructor
  Person.withoutEmail(this.name, this.id) : email = null;

  void displayBasicInfo() {
    print('Name: $name');
    print('ID: $id');
    if (email != null) {
      print('Email: $email');
    }
  }
}

// Student class - Inheritance, implements interfaces, uses mixin
class Student extends Person with AttendanceMixin implements Gradable, Printable {
  Map<String, double> grades = {}; // Map: courseCode -> grade
  Set<String> enrolledCourses = {}; // Set for unique courses

  // Constructor using super
  Student({required String name, required String id, String? email})
      : super(name: name, id: id, email: email);

  // Named constructor
  Student.quickCreate(String name, String id) : super(name: name, id: id);

  // Add grade for a course
  void addGrade(String courseCode, double grade) {
    if (grade < 0 || grade > 100) {
      throw RangeError('Grade must be between 0 and 100');
    }
    grades[courseCode] = grade;
    enrolledCourses.add(courseCode);
  }

  // Update existing grade
  void updateGrade(String courseCode, double newGrade) {
    if (!grades.containsKey(courseCode)) {
      throw Exception('Grade not found for course: $courseCode');
    }
    if (newGrade < 0 || newGrade > 100) {
      throw RangeError('Grade must be between 0 and 100');
    }
    grades[courseCode] = newGrade;
  }

  // Delete grade
  void deleteGrade(String courseCode) {
    if (!grades.containsKey(courseCode)) {
      throw Exception('Grade not found for course: $courseCode');
    }
    grades.remove(courseCode);
    enrolledCourses.remove(courseCode);
  }

  // Arrow function for checking if student has grades
  bool hasGrades() => grades.isNotEmpty;

  // Implement abstract method from Gradable
  @override
  double calculateAverage() {
    if (grades.isEmpty) return 0.0;
    double sum = grades.values.reduce((a, b) => a + b);
    return sum / grades.length;
  }

  // Implement abstract method from Gradable
  @override
  String getLetterGrade() {
    double avg = calculateAverage();
    // Using switch expression
    if (avg >= 90) return 'A';
    if (avg >= 80) return 'B';
    if (avg >= 70) return 'C';
    if (avg >= 60) return 'D';
    return 'F';
  }

  // Check pass/fail status - arrow function
  bool isPassing() => calculateAverage() >= 60;

  // Implement interface method
  @override
  void displayInfo() {
    print('\n========== Student Information ==========');
    displayBasicInfo();
    print('Enrolled Courses: ${enrolledCourses.length}');
    print('Average Grade: ${calculateAverage().toStringAsFixed(2)}');
    print('Letter Grade: ${getLetterGrade()}');
    print('Status: ${isPassing() ? "PASS" : "FAIL"}');
    print('Attendance: ${getAttendancePercentage().toStringAsFixed(1)}% (${getAttendanceStatus()})');
    
    if (grades.isNotEmpty) {
      print('\nGrades:');
      grades.forEach((course, grade) {
        print('  $course: $grade');
      });
    }
    print('=========================================\n');
  }

  // Implement interface method
  @override
  String getFormattedInfo() {
    return '$name (ID: $id) - Avg: ${calculateAverage().toStringAsFixed(2)} - Grade: ${getLetterGrade()}';
  }
}

// Course class
class Course {
  String name;
  String code;
  List<String> enrolledStudentIds = []; // List of student IDs

  Course({required this.name, required this.code});

  void enrollStudent(String studentId) {
    if (!enrolledStudentIds.contains(studentId)) {
      enrolledStudentIds.add(studentId);
    }
  }

  void removeStudent(String studentId) {
    enrolledStudentIds.remove(studentId);
  }

  // Arrow function
  int getEnrollmentCount() => enrolledStudentIds.length;

  void displayCourseInfo() {
    print('\nCourse: $name ($code)');
    print('Enrolled Students: ${enrolledStudentIds.length}');
  }
}

// Main GradeTracker class to manage everything
class GradeTracker {
  List<Student> students = [];
  Map<String, Course> courses = {}; // Map: courseCode -> Course
  Set<String> studentIds = {}; // Set for unique IDs

  // Add student with validation
  void addStudent({required String name, required String id, String? email}) {
    if (studentIds.contains(id)) {
      throw Exception('Student with ID $id already exists');
    }
    
    Student student = Student(name: name, id: id, email: email);
    students.add(student);
    studentIds.add(id);
    print('✓ Student added successfully!');
  }

  // Remove student
  void removeStudent(String id) {
    Student? student = findStudentById(id);
    if (student == null) {
      throw Exception('Student with ID $id not found');
    }
    
    students.remove(student);
    studentIds.remove(id);
    
    // Remove from all courses
    courses.forEach((code, course) {
      course.removeStudent(id);
    });
    
    print('✓ Student removed successfully!');
  }

  // Find student by ID - returns null if not found
  Student? findStudentById(String id) {
    for (var student in students) {
      if (student.id == id) {
        return student;
      }
    }
    return null;
  }

  // Add course
  void addCourse({required String name, required String code}) {
    if (courses.containsKey(code)) {
      throw Exception('Course with code $code already exists');
    }
    
    courses[code] = Course(name: name, code: code);
    print('✓ Course added successfully!');
  }

  // Add grade to student
  void addGradeToStudent(String studentId, String courseCode, double grade) {
    Student? student = findStudentById(studentId);
    if (student == null) {
      throw Exception('Student not found');
    }
    
    if (!courses.containsKey(courseCode)) {
      throw Exception('Course not found');
    }
    
    student.addGrade(courseCode, grade);
    courses[courseCode]!.enrollStudent(studentId);
    print('✓ Grade added successfully!');
  }

  // View all students - optional parameter
  void viewAllStudents([bool showDetails = false]) {
    if (students.isEmpty) {
      print('No students in the system.');
      return;
    }

    print('\n========== All Students ==========');
    // Using loop with index
    for (int i = 0; i < students.length; i++) {
      if (showDetails) {
        students[i].displayInfo();
      } else {
        print('${i + 1}. ${students[i].getFormattedInfo()}');
      }
    }
    print('==================================\n');
  }

  // Find top performer
  Student? getTopPerformer() {
    if (students.isEmpty) return null;
    
    Student topStudent = students[0];
    double highestAvg = topStudent.calculateAverage();
    
    // Loop through students to find highest average
    for (var student in students) {
      double avg = student.calculateAverage();
      if (avg > highestAvg) {
        highestAvg = avg;
        topStudent = student;
      }
    }
    
    return topStudent;
  }

  // Get failing students
  List<Student> getFailingStudents() {
    List<Student> failingStudents = [];
    
    for (var student in students) {
      if (!student.isPassing() && student.hasGrades()) {
        failingStudents.add(student);
      }
    }
    
    return failingStudents;
  }

  // Display reports
  void displayReports() {
    print('\n========== REPORTS ==========');
    print('Total Students: ${students.length}');
    print('Total Courses: ${courses.length}');
    
    // Top performer
    Student? top = getTopPerformer();
    if (top != null && top.hasGrades()) {
      print('\nTop Performer:');
      print('  ${top.name} - Average: ${top.calculateAverage().toStringAsFixed(2)}');
    }
    
    // Failing students
    List<Student> failing = getFailingStudents();
    print('\nFailing Students: ${failing.length}');
    if (failing.isNotEmpty) {
      for (var student in failing) {
        print('  - ${student.name} (${student.calculateAverage().toStringAsFixed(2)})');
      }
    }
    
    // Students by grade distribution
    Map<String, int> gradeDistribution = {};
    for (var student in students) {
      if (student.hasGrades()) {
        String grade = student.getLetterGrade();
        gradeDistribution[grade] = (gradeDistribution[grade] ?? 0) + 1;
      }
    }
    
    if (gradeDistribution.isNotEmpty) {
      print('\nGrade Distribution:');
      gradeDistribution.forEach((grade, count) {
        print('  $grade: $count student(s)');
      });
    }
    
    print('=============================\n');
  }

  // Display all courses
  void viewAllCourses() {
    if (courses.isEmpty) {
      print('No courses in the system.');
      return;
    }

    print('\n========== All Courses ==========');
    int index = 1;
    courses.forEach((code, course) {
      print('$index. ${course.name} (${course.code}) - ${course.getEnrollmentCount()} students');
      index++;
    });
    print('=================================\n');
  }
}

// Helper function to read user input
String? readInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync();
}

// Main function
void main() {
  GradeTracker tracker = GradeTracker();
  bool running = true;

  // Add some sample data
  try {
    tracker.addCourse(name: 'Mathematics', code: 'MATH101');
    tracker.addCourse(name: 'Physics', code: 'PHY101');
    tracker.addCourse(name: 'Computer Science', code: 'CS101');
  } catch (e) {
    print('Error adding courses: $e');
  }

  print('\n╔════════════════════════════════════════╗');
  print('║   Student Grade Tracker System   ║');
  print('╚════════════════════════════════════════╝\n');

  // Main menu loop
  while (running) {
    print('\n========== MAIN MENU ==========');
    print('1. Add Student');
    print('2. Add Grade');
    print('3. Update Grade');
    print('4. Delete Grade');
    print('5. View Student Details');
    print('6. View All Students');
    print('7. Mark Attendance');
    print('8. View All Courses');
    print('9. Add Course');
    print('10. Reports');
    print('11. Remove Student');
    print('0. Exit');
    print('===============================');

    String? choice = readInput('\nEnter your choice: ');

    try {
      // Using switch for menu navigation
      switch (choice) {
        case '1':
          // Add Student
          String? name = readInput('Enter student name: ');
          String? id = readInput('Enter student ID: ');
          String? email = readInput('Enter email (or press Enter to skip): ');

          if (name == null || name.isEmpty || id == null || id.isEmpty) {
            print('✗ Name and ID are required!');
            break;
          }

          tracker.addStudent(
            name: name,
            id: id,
            email: email!.isEmpty ? null : email,
          );
          break;

        case '2':
          // Add Grade
          String? studentId = readInput('Enter student ID: ');
          String? courseCode = readInput('Enter course code: ');
          String? gradeStr = readInput('Enter grade (0-100): ');

          if (studentId == null || courseCode == null || gradeStr == null) {
            print('✗ All fields are required!');
            break;
          }

          double grade = double.parse(gradeStr);
          tracker.addGradeToStudent(studentId, courseCode, grade);
          break;

        case '3':
          // Update Grade
          String? studentId = readInput('Enter student ID: ');
          String? courseCode = readInput('Enter course code: ');
          String? newGradeStr = readInput('Enter new grade (0-100): ');

          if (studentId == null || courseCode == null || newGradeStr == null) {
            print('✗ All fields are required!');
            break;
          }

          Student? student = tracker.findStudentById(studentId);
          if (student == null) {
            print('✗ Student not found!');
            break;
          }

          double newGrade = double.parse(newGradeStr);
          student.updateGrade(courseCode, newGrade);
          print('✓ Grade updated successfully!');
          break;

        case '4':
          // Delete Grade
          String? studentId = readInput('Enter student ID: ');
          String? courseCode = readInput('Enter course code: ');

          if (studentId == null || courseCode == null) {
            print('✗ All fields are required!');
            break;
          }

          Student? student = tracker.findStudentById(studentId);
          if (student == null) {
            print('✗ Student not found!');
            break;
          }

          student.deleteGrade(courseCode);
          print('✓ Grade deleted successfully!');
          break;

        case '5':
          // View Student Details
          String? studentId = readInput('Enter student ID: ');

          if (studentId == null || studentId.isEmpty) {
            print('✗ Student ID is required!');
            break;
          }

          Student? student = tracker.findStudentById(studentId);
          if (student == null) {
            print('✗ Student not found!');
          } else {
            student.displayInfo();
          }
          break;

        case '6':
          // View All Students
          tracker.viewAllStudents();
          break;

        case '7':
          // Mark Attendance
          String? studentId = readInput('Enter student ID: ');
          String? presentStr = readInput('Present? (y/n): ');

          if (studentId == null || presentStr == null) {
            print('✗ All fields are required!');
            break;
          }

          Student? student = tracker.findStudentById(studentId);
          if (student == null) {
            print('✗ Student not found!');
            break;
          }

          bool present = presentStr.toLowerCase() == 'y';
          student.markAttendance(present);
          print('✓ Attendance marked successfully!');
          print('Current Attendance: ${student.getAttendancePercentage().toStringAsFixed(1)}%');
          break;

        case '8':
          // View All Courses
          tracker.viewAllCourses();
          break;

        case '9':
          // Add Course
          String? name = readInput('Enter course name: ');
          String? code = readInput('Enter course code: ');

          if (name == null || name.isEmpty || code == null || code.isEmpty) {
            print('✗ Name and code are required!');
            break;
          }

          tracker.addCourse(name: name, code: code);
          break;

        case '10':
          // Reports
          tracker.displayReports();
          break;

        case '11':
          // Remove Student
          String? studentId = readInput('Enter student ID to remove: ');

          if (studentId == null || studentId.isEmpty) {
            print('✗ Student ID is required!');
            break;
          }

          tracker.removeStudent(studentId);
          break;

        case '0':
          // Exit
          print('\nThank you for using Student Grade Tracker!');
          running = false;
          break;

        default:
          print('✗ Invalid choice! Please try again.');
      }
    } catch (e) {
      // Error handling with try-catch
      print('✗ Error: $e');
    }
  }
}
