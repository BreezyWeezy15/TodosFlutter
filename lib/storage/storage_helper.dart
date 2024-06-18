
import 'package:get_storage/get_storage.dart';

class StorageHelper {
   static final _box = GetStorage();
   static void setValue(bool isDone){
     _box.write("isDone", isDone);
   }
   static bool isDone(){
     return _box.read("isDone") ?? false;
   }

   // DARK / LIGHT Mode
   static void setCurrentMode(bool isDark){
      _box.write("mode", isDark);
   }
   static bool getCurrentMode(){
      return _box.read("mode") ?? false;
   }

   static setCode(int position){
     _box.write("language", position);
   }
   static int getCode(){
     return _box.read("language") ?? 0;
   }

   static setSelectedLanguage(String language){
     _box.write("lingua", language);
   }
   static String getSelectedLanguage(){
     return _box.read("lingua") ?? "English";
   }
}