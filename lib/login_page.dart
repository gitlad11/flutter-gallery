import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  @override
  Login_state createState() => Login_state();
}

class Login_state extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Stack(
          children: [
            Image.asset("images/fxVE.gif", height: MediaQuery.of(context).size.height),
            Opacity(
              opacity: 0.3,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.black
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                constraints: const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}