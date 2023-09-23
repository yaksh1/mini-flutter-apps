import 'package:chatty/services/auth_service.dart';
import 'package:chatty/utils/my_button.dart';
import 'package:chatty/utils/my_textx_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  // logo
                  Icon(
                    PhosphorIcons.messenger_logo_fill,
                    color: Colors.blue[400],
                    size: 150.h,
                  ),
                  // welcome back
                  Text(
                    "Welcome back!",
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(
                    height: 30.h,
                  ),
                  //email textfield
                  MyTextField(
                      autocorrect: false,
                      obscureText: false,
                      suggestions: false,
                      controller: _email,
                      labelText: "Email",
                      hintText: "Email"),

                  SizedBox(
                    height: 15.h,
                  ),

                  //password textfield
                  MyTextField(
                      autocorrect: false,
                      obscureText: true,
                      suggestions: false,
                      controller: _password,
                      labelText: "Password",
                      hintText: "Password"),

                  SizedBox(
                    height: 25.h,
                  ),

                  // login button
                  MyButton(
                    buttonText: "Sign in",
                    onPressed: () async {
                      final authservice =
                          Provider.of<AuthService>(context, listen: false);

                      try {
                        await authservice.signInWithEmailAndPassword(
                            _email.text.trim(), _password.text);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home/', (route) => false);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString(),
                            ),
                          ),
                        );
                      }
                    },
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // not a member
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont't have an account?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/register/', (route) => false);
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
