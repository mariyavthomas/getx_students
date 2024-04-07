import 'package:flutter/material.dart';
import 'package:getxdtudenttable/pages/homescreen.dart';

import '../database/functionsaveget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final gets=Dbfunction();
  @override
  void initState() {
    home(context);
   super.initState();
   gets.getstudentdata();
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA-slu0GqqDfAyo41kxjSnEq70LMY6KBQRsCEWZXmkGlMuF55wgByU5_QkjA&s')
        ],
      ),
    );
  }

  Future<void> home(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
