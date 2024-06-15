
import 'package:get_storage/get_storage.dart';

class StorageHelper {
   static final _box = GetStorage();
   static void setValue(bool isDone){
     _box.write("isDone", isDone);
   }
   static bool isDone(){
     return _box.read("isDone") ?? false;
   }
}