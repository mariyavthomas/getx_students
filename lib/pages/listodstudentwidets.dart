import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getxdtudenttable/database/controller.dart';
import 'package:getxdtudenttable/pages/addstudents.dart';
import 'package:getxdtudenttable/widgets/detailpage.dart';

import '../database/functionsaveget.dart';

ValueNotifier<bool> scroll = ValueNotifier(false);

class ListOfstudents extends StatefulWidget {
  const ListOfstudents({super.key});

  @override
  State<ListOfstudents> createState() => _ListOfstudentsState();
}

class _ListOfstudentsState extends State<ListOfstudents> {
  //final gets=Dbfunction();

  void initState() {
    super.initState();
    gets.studentlist;
    gets.getstudentdata();
  }

  @override
  // ignore: override_on_non_overriding_member
  final gets = Get.put(Dbfunction());
  final controller = Get.put(studentcontroer());
  //final imagepath=studentcontroer.selectedimage.value;
  Widget build(BuildContext context) {
    return Column(
      children: [
        //GetBuilder<Dbfunction>(builder: (dbFunction)=>dbFunction.studentlist.isEmpty
        gets.studentlist.isEmpty
            ? Container(
                height: 500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Text('Emty List')
                  ],
                ),
              )
            : Expanded(child: Obx(() {
                return ListView.builder(
                  itemCount: gets.studentlist.length,
                  itemBuilder: (context, int index) {
                    print("list is ${gets.studentlist.length}");
                    final studendata =
                        gets.studentlist.reversed.toList()[index];
                    return InkWell(
                        onTap: () {
                          details(
                              context,
                              studendata.studentname,
                              studendata.rollnumber,
                              studendata.year,
                              studendata.place,
                              studendata.contact,
                              studendata.image,
                              studendata.id);
                        },
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                                label: 'Edit',
                                icon: Icons.edit,
                                backgroundColor:
                                    const Color.fromARGB(255, 33, 243, 72),
                                onPressed: (context) {
                                  Get.to(AddStudent(
                                    isedit: true,
                                    value: studendata,
                                  ));
                                })
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 41,
                                  backgroundImage:
                                      FileImage(File(studendata.image)),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  studendata.studentname!.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    details(
                                        context,
                                        studendata.studentname,
                                        studendata.rollnumber,
                                        studendata.year,
                                        studendata.place,
                                        studendata.contact,
                                        studendata.image,
                                        studendata.id);
                                  },
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                );
              }))
      ],
    );
  }
}
