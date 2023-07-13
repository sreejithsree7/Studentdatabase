import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/models/student_model.dart';
import 'package:student_record/views/student_detail_screen/student_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_record').values.toList();
  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  labelText: 'search', suffixIcon: Icon(Icons.search)),
              onChanged: (value) {
                searchStudent(value);
              },
            ),
            Expanded(
                child: studentDisplay.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemCount: studentDisplay.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StudentDetails(
                                      student: studentDisplay[index]),
                                ));
                              },
                              tileColor: Colors.blue.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              leading: CircleAvatar(
                                backgroundImage:
                                    studentDisplay[index].image.isEmpty
                                        ? AssetImage('assests/user.webp')
                                            as ImageProvider
                                        : FileImage(
                                            File(studentDisplay[index].image)),
                              ),
                              title: Text(studentDisplay[index].name),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          thickness: 5,
                          color: Colors.white,
                        ),
                      )
                    : Center(child: Text('No result found'))),
          ],
        ),
      ),
    );

  }

  searchStudent(String value) {
    setState(() {
      studentDisplay = studentList
          .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

}
