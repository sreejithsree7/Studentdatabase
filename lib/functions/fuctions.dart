import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/models/student_model.dart';
import 'package:student_record/views/Home_Screen/home_screen.dart';

addStudent(StudentModel model) async {
  final box = await Hive.openBox<StudentModel>('student_record');
  studentListNotifier.value.add(model);
  box.add(model);
  studentListNotifier.notifyListeners();
}

updatestudent(
    StudentModel oldStudent, StudentModel newStudent, int index) async {
  final box = await Hive.openBox<StudentModel>('student_record');

  studentListNotifier.value.remove(oldStudent);
  studentListNotifier.value.insert(index, newStudent);
  box.putAt(index, newStudent);
  studentListNotifier.notifyListeners();
}

removeStudent(int index) async {
  final box = await Hive.openBox<StudentModel>('student_record');
  studentListNotifier.value.removeAt(index);
  box.deleteAt(index);
  studentListNotifier.notifyListeners();
}

getAllStudent() async {
  final box = await Hive.openBox<StudentModel>('student_record');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(box.values);
 
  studentListNotifier.notifyListeners();
}

search() async {
  final box = await Hive.openBox<StudentModel>('student_record');
}
