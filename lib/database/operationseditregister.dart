import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxdtudenttable/database/functionsaveget.dart';
import 'package:getxdtudenttable/database/studentdb.dart';
import 'package:hive/hive.dart';

Future<void>register(
  BuildContext context,
  String studentname,
  String place,
  String rollnumber,
  String contact,
  String image,
  String year,
  GlobalKey<FormState>formkey )async{
    if(image.isEmpty){
      return;

    }
    if(formkey.currentState!.validate() &&
    studentname.isNotEmpty  &&
    place.isNotEmpty &&
    rollnumber.isNotEmpty&&
    year.isNotEmpty &&
    // ignore: unnecessary_null_comparison
    contact !=null 
    ){
      final add=Studentdb(studentname: studentname, contact: contact, place: place, rollnumber: rollnumber, year: year, image: image, id: -1);
      final getter=Get.put(Dbfunction());

      getter.savestudentdetails(add);
    showSnackBar(context,'Register successful',Colors.green);
      Navigator.pop(context);
    }
  }
void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
    backgroundColor: color,
  ));
}

Future<void> editStudent(context, File? image, String? name, String? rollnumber,String? year,
    String? place, String? contact,  int? id) async {
  final editbox = await Hive.openBox<Studentdb>('student');
  final existingStudent =
      editbox.values.firstWhere((element) => element.id == id);
  // ignore: unnecessary_null_comparison
  if (existingStudent != null) {
    existingStudent.studentname = name;
    existingStudent.image = image!.path;
    existingStudent.rollnumber = rollnumber;
    existingStudent.place = place;
    existingStudent.contact = contact;
    existingStudent.year=year!;

    await editbox.put(id, existingStudent);
    final getter = Get.put(Dbfunction());

    getter.getstudentdata();
    Navigator.pop(context);
  }
}
void delete(BuildContext context, int  id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete',
          ),
          content: Text('Remove the Student'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  dlt(context, id);
                },
                child: Text('Yes')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'))
          ],
        );
      });
}
Future<void> dlt(context, int id) async {
  final remove = await Hive.openBox<Studentdb>('student');
  remove.delete(id);
  final getter = Get.put(Dbfunction());
  getter.getstudentdata();
  showSnackBar(context, 'Deleted', Colors.red);
  Navigator.pop(context);
}