import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/functions/fuctions.dart';
import 'package:student_record/models/student_model.dart';
import 'package:student_record/views/Home_Screen/home_screen.dart';

class EditstudentPage extends StatefulWidget {
  EditstudentPage({
    super.key,
    required this.student,
    required this.index,
  });

  final StudentModel student;
  final int index;

  @override
  State<EditstudentPage> createState() => _EditstudentPageState();
}

class _EditstudentPageState extends State<EditstudentPage> {
  late String img = widget.student.image;

  @override
  Widget build(BuildContext context) {
    print('----->>  $img');
    TextEditingController nameCondroller =
        TextEditingController(text: widget.student.name);
    TextEditingController ageCondroller =
        TextEditingController(text: widget.student.age);
    TextEditingController phoneCondroller =
        TextEditingController(text: widget.student.phone);
    TextEditingController emailCondroller =
        TextEditingController(text: widget.student.email);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue.shade900),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 90,
              ),
              InkWell(
                  onTap: () async {
                    XFile? xFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (xFile != null) {
                    

                      img = xFile.path;

                      setState(() {});
                     
                    }
                  },
                  child: CircleAvatar(
                    minRadius: 80,
                    backgroundImage: img.isEmpty
                        ? AssetImage('assests/user.webp') as ImageProvider
                        : FileImage(File(img)),
                  )),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameCondroller,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      controller: ageCondroller,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Age',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: phoneCondroller,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailCondroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: Icon(Icons.email_rounded),
                    labelText: 'e-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      },
                      child: Text('cancel')),

                  // SizedBox(
                  //   width: 100,
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        if (nameCondroller.text.trim().isNotEmpty &&
                            ageCondroller.text.trim().isNotEmpty &&
                            phoneCondroller.text.trim().isNotEmpty &&
                            emailCondroller.text.trim().isNotEmpty) {
                          StudentModel model = StudentModel(
                              name: nameCondroller.text.trim(),
                              age: ageCondroller.text.trim(),
                              phone: phoneCondroller.text.trim(),
                              email: emailCondroller.text.trim(),
                              image: img);

                          updatestudent(widget.student, model, widget.index);

                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('update')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
