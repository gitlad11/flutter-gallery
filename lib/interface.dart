import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_art/settings.dart';
import 'package:flutter_art/profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

class Interface extends StatefulWidget{
  bool menu = false;

  @override
  initState(){

  }
  @override
  Interface_state createState() => Interface_state();
}

class Interface_state extends State<Interface>{
  var imagePicker = ImagePicker();
  late String photo = "";
  late File photoFile = File("");
  late bool permissionGranted = false;
  late bool cameraGranted = false;

  @override
  initState(){
    super.initState();
  }

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
      getImage();
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        permissionGranted = false;
      });
    }
  }
  Future _getCameraPermission() async {
    if (await Permission.camera.request().isGranted ){
      setState(() {
        cameraGranted = true;
      });
      getCamera();
    } else if  (await Permission.camera.request().isPermanentlyDenied){
      await openAppSettings();
    } else if (await Permission.camera.request().isDenied){
      setState(() {
        cameraGranted = false;
      });
    }
  }

  Future saveImage(File img) async{
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(img.path);
    final savedImage = await img.copy('${appDir.path}/$fileName');
    print(savedImage.path);
  }

  Future getCamera() async{
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    final imageFile = File(image!.path);
    setState(() {
      photoFile = imageFile;
      photo = imageFile.path;
    });
  }

  Future getImage() async{
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    final imageFile = File(image!.path);
      setState(() {
        photo = imageFile.path;
        photoFile = imageFile;
      });
  }

  List bottomBtns = <IconButton>[
    IconButton(icon: const Icon(Icons.drive_file_rename_outline,size: 34, color: Colors.white), onPressed: (){}),
    IconButton(icon: const Icon(Icons.flare, size: 34,  color: Colors.white), onPressed: (){}),
    IconButton(icon: const Icon(Icons.filter,size: 34, color: Colors.white), onPressed: (){}),
    IconButton(icon:  const Icon(Icons.crop,size: 34, color: Colors.white), onPressed: (){}),
    IconButton(icon:   const Icon(Icons.cut,size: 34, color: Colors.white) ,onPressed: (){}),

  ];

  var textStyle = const TextStyle(color: Colors.white,
    fontSize: 25, letterSpacing: 0.7,
    shadows: [

      Shadow(
        offset: Offset(4.0, 4.0),
        blurRadius: 5.0,
        color: Color.fromARGB(125, 0, 0, 255),
      ),
  ],);


  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.photo_camera),
        onPressed: (){
          _getCameraPermission();
        },
      ),
      appBar: AppBar(
        title: Text("Редактор ", style: textStyle),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            showAlertDialog(context);
          }, icon: const Icon(Icons.file_download, color: Colors.white, size: 30,)),
          IconButton(onPressed: (){
            setState(() {
              widget.menu ? widget.menu = false : widget.menu = true;
            });
          }, icon: const Icon(Icons.menu_rounded , color: Colors.white, size: 30))

        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black87,Colors.black87, Colors.black]),
          color: Colors.black87,
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 140,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: photo.isEmpty ? GestureDetector(
                onTap: () async{

                 await _getStoragePermission();
                },
                child: Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ SvgPicture.asset("images/gallery.svg", height: 60), const SizedBox(height: 5), const  Text("Выбрать фото",
                        style: TextStyle(color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)) ])
                ),
              ) :  PhotoView(imageProvider : FileImage(photoFile)),
            ),
            widget.menu ?
            Positioned(
              right: 10,
              top: 5,
              child:  Container( height: 150, width: 200, decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                          }, child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.account_circle, color: Colors.black54, size: 32),
                          SizedBox(width: 4),
                          Text("Профиль", style: TextStyle(color: Colors.black87, fontSize: 22))],)),
                      const Divider(height: 1, color: Colors.black87),

                      TextButton(onPressed: (){
                        print(photo);
                      }, child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo, color: Colors.black54, size: 32),
                          SizedBox(width: 4),
                          Text("Выбрать фото", style: TextStyle(color: Colors.black87, fontSize: 22))],)),
                      const Divider(height: 1, color: Colors.black87),

                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                      }, child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.settings, color: Colors.black54, size: 32),
                          SizedBox(width: 4),
                          Text("Настройки", style: TextStyle(color: Colors.black87, fontSize: 22))],)),

                    ],

                  )
              ),

            ) : const SizedBox(),


    Positioned(
      bottom: 5,
      right: 25,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width : 12);
            },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bottomBtns.length,
                      itemBuilder: (context, index) => bottomBtns[index],
                    ),
        ),
      ),
    ),
            

          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text("Продолжить"),
      onPressed:  () {
        saveImage(photoFile);
        Navigator.pop(context, "ok");
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Отмена", style: TextStyle(color: Colors.red)),
      onPressed:  () {
        Navigator.pop(context, "cancel");
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Сохранить фото?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}