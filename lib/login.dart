import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:projectflutter/home.dart';
import 'package:projectflutter/register.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _email, _password;
  @override
  Widget build(BuildContext context) {
return Scaffold(
        appBar: AppBar(
          title: Text("เข้าสู่ระบบ", style: TextStyle(color: Colors.white)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(  
              
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue[300], 
                        Colors.blue])
                        ),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) => _email = value.trim(),
                      decoration: InputDecoration(labelText: 'อีเมล'),
                    ),
                    TextFormField(
                      onChanged: (value) => _password = value.trim(),
                      decoration: InputDecoration(labelText: 'รหัสผ่าน'),
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: () {
                        login();
                      },
                      child: Text('ยืนยัน'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text('สมัครสมาชิก'),
                    )
                  ],
                )),
          ),
        )));
  }

    Future<void> login() async {
      print(_email);
      print(_password);

      if ((_email == null || _email == '') || (_password == null || _password == '')) {
        showAlertDialog(context,"โปรดกรอกข้อมูลให้ครบถ้วน");

      } else{
        await firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((response) {
            print("เข้าใช้งานสำเร็จ");
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) => Home());
            Navigator.of(context).pushAndRemoveUntil(
                materialPageRoute, (Route<dynamic> route) => false);
          }).catchError((response) {
            print("เข้าใช้งานล้มเหลว");
            showAlertDialog(context,"อีเมล หรือ พาสเวิร์ดไม่ถูกต้อง");
        });
      }
    }
    
    showAlertDialog(BuildContext context,text) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop(); },
    );

    AlertDialog alert = AlertDialog(
      title: Text("แจ้งเตือน"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
