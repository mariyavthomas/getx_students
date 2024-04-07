

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'studentdb.dart';

class Dbfunction extends GetxController{
  RxList studentlist=[].obs;
  Future<void>savestudentdetails(Studentdb value)async{
    final student= await Hive.openBox<Studentdb>('student');
    final id =await student.add(value);
    // ignore: unused_local_variable
    final studentdata=student.get(id);
    await student.put(id, 
  Studentdb(
  studentname: studentdata!.studentname,
  contact: studentdata.contact,
  place: studentdata.place,
  rollnumber: studentdata.rollnumber,
  year: studentdata.year,
  image: studentdata.image,
  id: id
  ));
  getstudentdata();
  }

Future<void>getstudentdata()async{
  final student= await Hive.openBox<Studentdb>('student');
  // ignore: invalid_use_of_protected_member
studentlist.value.clear();
  // ignore: invalid_use_of_protected_member
  studentlist.value.addAll(student.values);
  //print("list of length ith is ${studentlist.length}");
 studentlist.refresh();

}

}