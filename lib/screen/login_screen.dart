import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.heightOf(context);
    final width = MediaQuery.widthOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: Colors.white),
              ),

              Positioned(
                top: 0,
                child: SizedBox(
                  height: height * 0.5,
                  width: width,
                  child: Image.asset('assets/Head.png', fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: height * 0.075,
                left: 0,
                right: 0,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: Image.asset('assets/whiteLogo.png'),
                    ),
                    Text(
                      'Sign in to your Account',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontSize: height * 0.05),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Enter your email & password to sign in',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: height * 0.014,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: height * 0.38,
                left: (width - (width * 0.88)) / 2,
                width: width * 0.88,
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.48,
                  width: width * 0.88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        icon: Image.asset('assets/icons/google.png', scale: 2),
                        onPressed: () {},
                        label: Text(
                          'Continue with Google',
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: height * 0.02,
                              ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Or',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black54,
                          fontSize: height * 0.014,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: width * 0.7,
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  hintText: 'name@example.com',
                                  prefixIcon: Icon(Icons.email_outlined),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',

                                  prefixIcon: Icon(Icons.email_outlined),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CheckboxListTile(
                                    title: Text(
                                      'Remember me',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: height * 0.013,
                                            color: Color.fromARGB(
                                              255,
                                              151,
                                              151,
                                              151,
                                            ),
                                          ),
                                    ),
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forget Password?',

                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: height * 0.013,
                                            color: Color.fromARGB(
                                              255,
                                              42,
                                              105,
                                              232,
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {},

                                child: Container(
                                  width: width * 0.7,
                                  height: height * 0.062,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 29, 97, 231),
                                        Color.fromARGB(255, 42, 113, 255),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Log In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: height * 0.018,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Dont have an account?'),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Sign Up'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
