import 'package:flutter/material.dart';
import 'package:todos_app/storage/storage_helper.dart';
import 'package:todos_app/ui/home_page.dart';
import 'package:todos_app/ui/intro_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
        if(StorageHelper.isDone()){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        } else {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => const IntroPage()));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset("assets/images/tasks.png",width: 250,height: 250,fit: BoxFit.cover,
          filterQuality: FilterQuality.high,),
        ),
      ),
    );
  }
}
