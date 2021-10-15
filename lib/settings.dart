import 'package:flutter_art/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget{

  @override
  Settings_state createState() => Settings_state();
}

class Settings_state extends State<Settings>{

  var textStyle = const TextStyle(color: Colors.black87,
    fontSize: 25, letterSpacing: 0.7,
    shadows: [

      Shadow(
        offset: Offset(3.0, 3.0),
        blurRadius: 2.0,
        color: Color.fromARGB(0, 0, 0, 0),
      ),
    ],);

  var textStyle2 = const TextStyle(color: Colors.black87,
      fontSize: 23, letterSpacing: 0.4, overflow: TextOverflow.ellipsis, fontStyle: FontStyle.normal);

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        leading: IconButton( onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_rounded, size: 32, color: Colors.black87)),
        title: Text("Настройки", style: textStyle),
        backgroundColor: Colors.white70,
        elevation: 0,
      ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white70
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Общие настройки", style: TextStyle(color: Colors.black87, fontSize: 24)),
                  ],
                ),
                const Divider(height: 1, color: Colors.black54),
                TextButton(onPressed: (){}, child: Row(
                  children: [
                  const Icon(Icons.notifications, size: 34, color: Colors.black54, ),
                    const SizedBox(width: 4),
                    Text("Уведомления", style: textStyle2)
                ] )),
                TextButton(onPressed: (){}, child: Row(
                    children: [
                      const Icon(Icons.architecture, size: 34, color: Colors.black54, ),
                      const SizedBox(width: 4),
                      Text("О приложении", style: textStyle2)
                    ] )),
                TextButton(onPressed: (){}, child: Row(
                    children: [
                      const Icon(Icons.miscellaneous_services, size: 34, color: Colors.black54, ),
                      const SizedBox(width: 4),
                      Text("Сообщить об ошибке", style: textStyle2)
                    ] )),
                TextButton(onPressed: (){}, child: Row(
                    children: [
                      const Icon(Icons.share_rounded, size: 34, color: Colors.black54, ),
                      const SizedBox(width: 4),
                      Text("Поделиться", style: textStyle2)
                    ] )),

              ],
            ),

    ),
    );
  }
}