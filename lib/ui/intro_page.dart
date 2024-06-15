import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todos_app/storage/storage_helper.dart';
import 'package:todos_app/utils.dart';

import 'home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  final List<String> _titles = ["Add Tasks","Get Notified","Finish Tasks"];
  final List<String> _descriptions = [
    "Get Started with adding your tasks",
    "Notifications are at your service to get you notificed.",
    "Tasks Done! Congratulations"
  ];
  final List<String> _images = ["assets/images/add.png", "assets/images/notification.png",
    "assets/images/finish.png"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index){
                    setState(() {
                      selectedIndex = index;
                    });
                },
                itemCount: _titles.length,
                itemBuilder: (context,index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_titles[index],style: getBoldFont().copyWith(fontSize: 35),),
                      Image.asset(_images[index],width: 300,height: 300,),
                      Text(_descriptions[index],style: getBoldFont().copyWith(fontSize: 20),
                      textAlign: TextAlign.center,),
                    ],
                  );
                },
              )),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      StorageHelper.setValue(true);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueGrey
                      ),
                      child:  Center(
                        child: Text("Skip",style: getNormalFont().copyWith(color: Colors.white),),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1,),
                  Row(
                    children: List.generate(_titles.length, (index){
                      return Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: selectedIndex == index ? Colors.grey.shade400 : Colors.blueGrey
                        ),
                      );
                    }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
