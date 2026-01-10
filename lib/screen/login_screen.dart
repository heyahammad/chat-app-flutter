import 'package:flutter/material.dart';
import 'package:say/screen/signup_screeen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();
  bool rememberme = false;
  bool islogin = true;
  String mail = '';
  String password = '';

  void login() {
    if (keyForm.currentState!.validate()) {
      keyForm.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.heightOf(context);
    final width = MediaQuery.widthOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /*



Heres the Solid Background.



*/
          Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: Colors.white),
              ),

              /*



Heres the Header logo, texts and blue section.



*/
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
                    SizedBox(height: 15),
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

              /*



Heres the floating from.



*/
              Positioned(
                top: height * 0.36,
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

                      Text(
                        'Or',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black54,
                          fontSize: height * 0.014,
                        ),
                      ),

                      /*



Heres the exact from appears.



*/
                      SizedBox(
                        width: width * 0.7,
                        child: Form(
                          key: keyForm,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  hintText: 'name@example.com',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  prefixIcon: Icon(Icons.email_outlined),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 42, 105, 232),
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
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,

                                validator: (value) {
                                  if (!value.toString().contains('@') ||
                                      value == null) {
                                    return 'Please enter a valid email address';
                                  }
                                },
                                onSaved: (newValue) =>
                                    mail = newValue.toString(),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),

                                  prefixIcon: Icon(Icons.password_outlined),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 42, 105, 232),
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
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,

                                validator: (value) {
                                  if (value.toString().isEmpty ||
                                      value == null) {
                                    return 'Please enter your password';
                                  }
                                },
                                onSaved: (newValue) =>
                                    password = newValue.toString(),
                              ),

                              /*



TextField (mail, password end here)



*/
                              SizedBox(height: 16),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        rememberme = !rememberme;
                                      });
                                    },
                                    child: rememberme
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromARGB(
                                                  255,
                                                  42,
                                                  105,
                                                  232,
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                'Remember me',

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
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromARGB(
                                                  255,
                                                  184,
                                                  184,
                                                  184,
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                'Remember me',

                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontSize: height * 0.013,
                                                      color: Color.fromARGB(
                                                        255,
                                                        184,
                                                        184,
                                                        184,
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
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
                              SizedBox(height: 16),

                              /*



Heres the Log IN Button



*/
                              InkWell(
                                onTap: () {
                                  login();
                                },

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
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Dont have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        /*
                                        
                                        Custom animation page switching
                                        
                                        */
                                        PageRouteBuilder(
                                          pageBuilder:
                                              (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                              ) => const SignUpScreen(),
                                          transitionsBuilder:
                                              (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                                child,
                                              ) {
                                                const begin = Offset(
                                                  1.0,
                                                  0.0,
                                                ); // Start position (bottom of screen)
                                                const end = Offset
                                                    .zero; // End position (original position)
                                                const curve = Curves
                                                    .ease; // Animation curve

                                                var tween =
                                                    Tween(
                                                      begin: begin,
                                                      end: end,
                                                    ).chain(
                                                      CurveTween(curve: curve),
                                                    );

                                                return SlideTransition(
                                                  position: animation.drive(
                                                    tween,
                                                  ),
                                                  child: child,
                                                );
                                              },
                                          transitionDuration: const Duration(
                                            milliseconds: 500,
                                          ), // Duration for push and pop
                                          reverseTransitionDuration: const Duration(
                                            milliseconds: 500,
                                          ), // Ensures pop has a noticeable animation
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
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
