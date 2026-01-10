import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:say/screen/home_screen.dart';

final firestore = FirebaseFirestore.instance;

final auth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isLogin});
  final bool isLogin;
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final keyForm = GlobalKey<FormState>();
  String firstname = '';
  String lastname = '';
  String username = '';
  DateTime? dob;
  String mail = '';
  String password = '';
  bool rememberme = false;
  bool? islogin;

  @override
  void initState() {
    super.initState();
    islogin = widget.isLogin;
  }

  void login() async {
    if (keyForm.currentState!.validate()) {
      keyForm.currentState!.save();

      try {
        await auth.signInWithEmailAndPassword(email: mail, password: password);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Log in failed')));
      }
    }
  }

  void signup() async {
    if (keyForm.currentState!.validate() && dob != null) {
      keyForm.currentState!.save();

      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: mail, password: password);

        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
          'dob': dob!.toIso8601String(),
          'created_at': DateTime.now(),
        });

        if (mounted) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => HomneScreen()));
        }

        /* save user credentials*/
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentication Failed')),
        );
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.heightOf(context);
    final width = MediaQuery.widthOf(context);
    /*

Login Widget start


*/

    Widget content = Scaffold(
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
                                      setState(() {
                                        islogin = false;
                                      });
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

    /*




/////////////////////////////
Login Widget end
////////////////////////////





*/

    if (islogin == false) {
      content = Scaffold(
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
                        'Sign up to an Account',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: height * 0.05,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Enter your details to create a new account',
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
                    height: height * 0.6,
                    width: width * 0.88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: keyForm,
                      /*

actual form

*/
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            icon: Image.asset(
                              'assets/icons/google.png',
                              scale: 2,
                            ),
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
                            'Or enter your details',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Colors.black54,
                                  fontSize: height * 0.014,
                                ),
                          ),

                          /*



Heres the exact from appears.



*/

                          /*

details in two row start

*/
                          SizedBox(
                            width: width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.325,
                                  child: Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'First name',
                                        hintText: 'Faisal',
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

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              42,
                                              105,
                                              232,
                                            ),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.words,

                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                      },
                                      onSaved: (newValue) =>
                                          firstname = newValue.toString(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.325,
                                  child: Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'Last name',
                                        hintText: 'Ahammad',
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

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              42,
                                              105,
                                              232,
                                            ),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.words,

                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Please enter your last name';
                                        }
                                      },
                                      onSaved: (newValue) =>
                                          lastname = newValue.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.325,
                                  child: Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                        hintText: 'heyahammad',
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

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              42,
                                              105,
                                              232,
                                            ),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,

                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Please choose a username';
                                        }
                                      },
                                      onSaved: (newValue) =>
                                          username = newValue.toString(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.056,
                                  width: width * 0.325,
                                  child: GestureDetector(
                                    onTap: () async {
                                      dob = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      setState(() {
                                        dob = dob;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        dob == null
                                            ? 'Date of Birth'
                                            : '${dob!.day.toString()}/${dob!.month.toString()}/${dob!.year.toString()}',
                                        style: dob == null
                                            ? Theme.of(
                                                context,
                                              ).textTheme.titleMedium!.copyWith(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              )
                                            : Theme.of(
                                                context,
                                              ).textTheme.titleMedium!.copyWith(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /*

details in two row end

*/
                          SizedBox(
                            width: width * 0.7,
                            child: TextFormField(
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
                              onSaved: (newValue) => mail = newValue.toString(),
                            ),
                          ),

                          SizedBox(
                            width: width * 0.7,
                            child: TextFormField(
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
                                if (value.toString().isEmpty || value == null) {
                                  return 'Please enter your password';
                                }
                                if (value.trim().length < 6 ||
                                    value.trim().length > 8) {
                                  return 'Password must be 6-8 characters long';
                                }
                              },
                              onSaved: (newValue) =>
                                  password = newValue.toString(),
                            ),
                          ),

                          /*Buttons here*/
                          InkWell(
                            onTap: () {
                              signup();
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
                                  'Sign Up',
                                  style: Theme.of(context).textTheme.titleLarge!
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
                              Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    islogin = true;
                                  });
                                },
                                child: Text(
                                  'Sign In',
                                  style: Theme.of(context).textTheme.titleLarge!
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

                          /*Button section ends*/
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return content;
  }
}
