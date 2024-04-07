
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdtudenttable/database/controller.dart';
import 'package:getxdtudenttable/database/studentdb.dart';

import '../database/operationseditregister.dart';

// ignore: must_be_immutable
class AddStudent extends StatefulWidget {
  AddStudent({super.key, required this.isedit, this.value});
  bool isedit = false;
  Studentdb? value;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  static String? phoneValidator(
    String? value,
  ) {
    final trimmedvalue = value?.trim();

    if (trimmedvalue == null || trimmedvalue.isEmpty) {
      return 'Enter your Phone Number';
    }

    final RegExp phoneRegExp =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

    if (!phoneRegExp.hasMatch(trimmedvalue)) {
      return 'Enter your Number';
    }
    return null;
  }

  File? selectedimage;
  List<String> rollNumber = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  List<String> year = ['First year', 'Second Year', 'third year'];
  String? selectrollnumber;
  String? selectyear;
  final studentnamecontroller = TextEditingController();
  final contactcontroller = TextEditingController();
  final placecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final controller = Get.put(studentcontroer());
  

  @override
  Widget build(BuildContext context) {
    print(widget.value?.year);
    if (widget.isedit) {
      studentnamecontroller.text = widget.value!.studentname.toString();
      contactcontroller.text = widget.value!.contact.toString();
      placecontroller.text = widget.value!.place.toString();
      controller.selectedimage.value = widget.value!.image.toString();
       selectrollnumber = widget.value?.rollnumber;
      selectyear = widget.value?.year;
    }
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
          backgroundColor: Colors.teal[300],
          title: widget.isedit ? Text('Edit') : Text('Register')),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(border: Border.all()),
                      child: controller.selectedimage.isNotEmpty
                          ? Image.file(
                              File(controller.selectedimage.value),
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                              size: 40,
                            )),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            controller.getImage();
                          },
                          icon: Icon(Icons.image))
                    ],
                  )
                ],
              );
            }),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: ,
                controller: studentnamecontroller,
                decoration: InputDecoration(
                    hintText: 'Student Name', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: phoneValidator,
                controller: contactcontroller,
                decoration: InputDecoration(
                    hintText: 'Contact', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: placecontroller,
                decoration: InputDecoration(
                    hintText: 'Place', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'Select rollnumber',
                  focusedBorder: UnderlineInputBorder(),
                  filled: true,
                  fillColor: Colors.greenAccent,
                ),
                //  dropdownColor: const Color.fromARGB(255, 171, 185, 178),
                value: selectrollnumber,
                onChanged: (String? newValue) {
                  selectrollnumber = newValue!;
                },
                items: rollNumber.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: DropdownButtonFormField(
                // onChanged: (){},
                decoration: InputDecoration(
                  hintText: 'Select Year ',
                  focusedBorder: UnderlineInputBorder(),
                  filled: true,
                  fillColor: Colors.greenAccent,
                ),
                //  dropdownColor: const Color.fromARGB(255, 171, 185, 178),
                value: selectyear,
                onChanged: (String? newvalue1) {
                  selectyear = newvalue1!;
                  //controller.update();
                },
                items: year.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
           
            SizedBox(
              height: 20,
            ),
            widget.isedit == false
                ? InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate() &&
                          studentnamecontroller.text.isNotEmpty &&
                          selectrollnumber != null &&
                          contactcontroller.text.isNotEmpty &&
                          placecontroller.text.isNotEmpty &&
                          selectrollnumber != null &&
                          selectyear != null &&
                          controller.selectedimage.value.isNotEmpty) {
                        register(
                            context,
                            studentnamecontroller.text.trim(),
                            placecontroller.text.trim(),
                            selectrollnumber.toString(),
                            contactcontroller.text.trim(),
                            controller.selectedimage.value,
                            selectyear.toString(),
                            formkey);
                      } else {
                        studentnamecontroller.clear();
                        placecontroller.clear();
                        selectrollnumber = null;

                        contactcontroller.clear();
                        selectyear = null;
                        selectedimage = controller.getImage();

                        showSnackBar(context, 'Register fail', Colors.red);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate() &&
                          studentnamecontroller.text.isNotEmpty &&
                          contactcontroller.text.isNotEmpty &&
                          selectrollnumber != null &&
                          selectyear != null) {
                        editStudent(
                            context,
                            File(
                              controller.selectedimage.toString(),
                            ),
                            studentnamecontroller.text,
                            selectrollnumber.toString(),
                            selectyear.toString(),
                            placecontroller.text,
                            contactcontroller.text,
                            int.parse(widget.value!.id.toString()));
                      } else {
                        studentnamecontroller.clear();
                        contactcontroller.clear();
                        selectedimage = selectrollnumber = null;
                        placecontroller.clear();
                        showSnackBar(context, 'Register faild', Colors.red);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text('Update'),
                      ),
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}
