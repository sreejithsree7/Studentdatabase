// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_record/models/student_model.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: student.image.isEmpty
                ? AssetImage('assests/user.webp') as ImageProvider
                : FileImage(File(student.image)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Name    :     ',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                student.name,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Age        :     ',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                student.age,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Phone    :     ',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                student.phone,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'E-Mail    :     ',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                student.email,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('close')),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
