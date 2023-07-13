// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_record/functions/fuctions.dart';
import 'package:student_record/models/student_model.dart';
import 'package:student_record/views/addstudent_screen/addstudent.dart';
import 'package:student_record/views/edit_student_screen/edit_student_screen.dart';
import 'package:student_record/views/search_screen/search_screen.dart';
import 'package:student_record/views/student_detail_screen/student_detail_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (context, studentBuilderValue, child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: studentBuilderValue.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return StudentDetails(
                          student: studentBuilderValue[index]);
                    },
                  )),
                  tileColor: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  leading: CircleAvatar(
                    backgroundImage: studentBuilderValue[index].image.isEmpty
                        ? AssetImage('assests/user.webp') as ImageProvider
                        : FileImage(File(studentBuilderValue[index].image)),
                  ),
                  title: Text(studentBuilderValue[index].name),
                  subtitle: Text(studentBuilderValue[index].age),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return EditstudentPage(
                                  student: studentBuilderValue[index],
                                  index: index,
                                );
                              },
                            ));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            removeStudent(index);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              thickness: 5,
              color: Colors.white,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddstudentPage();
            },
          ));
        },
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
// ValueNotifier<List<String>> name = ValueNotifier([]);
