import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_art/login_page.dart';

class Profile extends StatefulWidget{
  @override

  Profile_state createState() => Profile_state();
}

class Profile_state extends State<Profile>{
  List photos = [
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          }, icon: const Icon(Icons.exit_to_app, color: Colors.white70, size: 30))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.black87,
        ),
        child: Column(


          children:  [
           const Expanded(
                flex: 4,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 88,
                    child: CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 86,
                      child: Text('AH'),
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
                child: Center(child: Column(
                  children: const [
                   Text("имя фамилия", style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 0.5), overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 4),
                    Text("efimovi420@gmail.com", style: TextStyle(color: Colors.white70, fontSize: 17, letterSpacing: 0.1),)
                  ],
                ))),
            const Divider(height: 1, color: Colors.white70),
            const SizedBox(height: 20),
            const Expanded(flex: 1,child: Center(child: Text("Галерея:", style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 0.5), overflow: TextOverflow.ellipsis))),
            Expanded( flex: 4, child: Center(child: Container(
                                                    padding: const EdgeInsets.all(10),
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10)),
                                                    child: photos.isNotEmpty ? ListView.separated(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        separatorBuilder: (BuildContext context, int index) {return const SizedBox(width : 5);}, itemCount: photos.length,
                                                        itemBuilder: (context, index) => Image.network(
                                                          photos[index],
                                                          width: 160.0,
                                                        )) : Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [SvgPicture.asset(
                                                          "images/folder.svg",
                                                          height: 100,
                                                    ), const Text("галерея пуста!", style: TextStyle(fontSize: 20))
                                                          ]
                                                        ),

            ),)
            )
          ],
        ),
      ),
    );
  }
}