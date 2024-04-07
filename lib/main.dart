import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdtudenttable/database/functionsaveget.dart';

import 'package:getxdtudenttable/database/studentdb.dart';
import 'package:getxdtudenttable/pages/homescreen.dart';

// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.openBox<Studentdb>('student');
  if(!Hive.isAdapterRegistered(StudentdbAdapter().typeId)){
    Hive.registerAdapter(StudentdbAdapter());
  }

  await loadData();
  runApp( Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  


  
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students',
      home:HomeScreen() ,
    );
  }
}
Future<void> loadData() async {
  final controller = Get.put(Dbfunction());
  await controller.getstudentdata();
}