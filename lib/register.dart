import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectflutter/login.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  String _email, _password, _confirmpassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สมัครสมาชิก", style: TextStyle(color: Colors.white)),
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
                    TextFormField(
                      onChanged: (value) => _confirmpassword = value.trim(),
                      decoration: InputDecoration(labelText: 'ยืนยันรหัสผ่าน'),
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: () {
                        register();
                      },
                      child: Text('ยืนยัน'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('เช้าสู่ระบบ'),
                    )
                  ],
                )),
          ),
        )));
  }

  Future<void> register() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    print(_email);
    print(_password);

    if ((_email == null || _email == '') || (_password == null || _password == '') || (_confirmpassword == null || _confirmpassword == '')) {
      showAlertDialog(context,'โปรดกรอกข้อมูลให้ครบถ้วน');

    } else if (_password.length <= 5){
      showAlertDialog(context,'รหัสผ่านควรยาวอย่างน้อย 6 ตัวอักษร');

    } else if (_password != _confirmpassword) {
      showAlertDialog(context,'รหัสผ่านไม่ตรงกัน');

    } else {
      await firebaseAuth
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
          print('ลงทะเบียนสำเร็จ');          
          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Login());
          Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
          
          showAlertDialog(context,'ลงทะเบียนสำเร็จ');

      }).catchError((user) {
        print('ลงทะเบียนล้มเหลว');
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
