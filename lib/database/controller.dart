import 'package:get/get.dart';
import 'package:getxdtudenttable/database/studentdb.dart';
import 'package:image_picker/image_picker.dart';

class studentcontroer extends GetxController{
List<Studentdb>students=[];

List<Studentdb> get Studentlist =>students;
RxString selectedimage=''.obs;
RxString searchtxt=''.obs;

getImage() async{
  final picker=ImagePicker();
  final pickedimage= await picker.pickImage(source: ImageSource.gallery);
  if(pickedimage!=null){
    selectedimage.value=pickedimage.path;
  }
}
search(String value){
  searchtxt=value.obs;
}


}