import 'package:ecarihesap/screens/giris_screen.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key  key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Sign Up",
                        style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16),
                          hintText: "Ad",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.black54, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            BorderSide(color: Colors.grey.shade100, width: 2),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),

                    child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16),
                          hintText: "E-mail",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.black54, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            BorderSide(color: Colors.grey.shade100, width: 2),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16),
                          hintText: "Şifre",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            BorderSide(color: Colors.black54, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            BorderSide(color: Colors.grey.shade100, width: 2),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,

                          value: isChecked,
                          onChanged: (bool  value) {
                            setState(() {
                              isChecked = value ;
                            });
                          },
                        ),
                        Text("By signing up, you agree to the Terms of\n Service and Privacy Policy"),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 380,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Üye Ol",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff7F3DFF),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Zaten hesabınız var mı?",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                      TextButton(
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(
                            color: Color(0xff7F3DFF),
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GirisScreen()),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
