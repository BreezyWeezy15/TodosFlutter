
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart' hide Trans;
import 'package:todos_app/languages/locale_keys.g.dart';
import 'package:todos_app/storage/storage_helper.dart';
import 'package:todos_app/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  String mode = "Light";
  String language = "English";
  int selectedRadio = 0;
  final List<String> _locales  = ["en","fr","es","it"];
  late List<String> _languages;
  @override
  void initState() {
    super.initState();
    setState(() {
      language = StorageHelper.getSelectedLanguage();
      selectedRadio = StorageHelper.getCode();
      isDark = StorageHelper.getCurrentMode();
      isDark ? mode = LocaleKeys.dark.tr() : mode = LocaleKeys.light.tr();
    });
  }

  @override
  Widget build(BuildContext context) {
    _languages = [
      LocaleKeys.english.tr(),
      LocaleKeys.french.tr(),
      LocaleKeys.spanish.tr(),
      LocaleKeys.italian.tr()];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/images/arrow.png",width: 25,height: 25,),
                  ),
                  const Gap(5),
                  Text(LocaleKeys.settings.tr(),style: getBoldFont().copyWith(fontSize: 20),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.currentMode.tr(),style: getBoldFont().copyWith(fontSize: 20),),
                        Text(mode,style: getMedFont().copyWith(fontSize: 18),)
                      ],
                    ),
                  ),
                  Switch(
                      value: isDark,
                      onChanged: (value){
                     setState(() {
                       isDark = value;
                       isDark ? mode = LocaleKeys.dark.tr() : mode = LocaleKeys.light.tr();
                     });
                     if(isDark){
                       StorageHelper.setValue(true);
                       Get.changeThemeMode(ThemeMode.dark);
                     } else {
                       StorageHelper.setValue(false);
                       Get.changeThemeMode(ThemeMode.light);
                     }

                  })
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.currentLanguage.tr(),style: getBoldFont().copyWith(fontSize: 20),),
                        Text(language,style: getMedFont().copyWith(fontSize: 18),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      // show bottom sheet with 3 languages
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              content: StatefulBuilder(
                                builder: (context,state){
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List<Widget>.generate(_languages.length, (index){
                                        return Row(
                                          children: [
                                            Expanded(child: Text(_languages[index],style: getBoldFont().copyWith(fontSize: 18),)),
                                            const SizedBox(width: 10,),
                                            Radio<int>(
                                                value: index,
                                                groupValue: selectedRadio,
                                                onChanged: (index) async {
                                                  setState(() {
                                                    selectedRadio = index!;
                                                    language = _languages[index];
                                                  });
                                                  await context.setLocale(Locale(_locales[index!]));
                                                  Get.updateLocale(Locale(_locales[index]));
                                                  StorageHelper.setSelectedLanguage(language);
                                                  StorageHelper.setCode(selectedRadio);
                                                  if (context.mounted) Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                    },
                    child: const Icon(Icons.language,size: 25,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
