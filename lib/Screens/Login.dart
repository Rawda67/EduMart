
import 'package:edu_mart/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';


import '../Constant.dart';
import 'Forgetpassword.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey=GlobalKey();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body:
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70,),
                  Image.asset("assets/SignIn.png",height: 300,),

                  Text(" Log In",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color:Constant.primaryColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'you must Enter Something!';}
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: const Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          hintText: 'Enter your Email',
                          hintStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.email_rounded,
                              size: 30,
                              color: Constant.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Constant.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Constant.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color:Constant.errormess,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorStyle:  TextStyle(
                            color: Constant.errormess,
                          )
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'you must Enter Something!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: const Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          hintText: 'Enter your Password',
                          hintStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.password_outlined,
                              size: 30,
                              color: Constant.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Constant.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Constant.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Constant.errormess,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorStyle:  TextStyle(
                            color:  Constant.errormess,
                          )
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgetpassword()));
                      },
                          child: Text("Forget Password?",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Constant.primaryColor,
                          ),)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await LoginUser();
                          FirebaseAuth.instance.currentUser!.emailVerified?Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),):ShowSnackBar(context, "verify Your Email First");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ShowSnackBar(context, "No user found with this Email");
                          } else if (e.code == 'wrong-password') {
                            ShowSnackBar(context, "Wrong password");
                          } else {
                            ShowSnackBar(context, e.message ?? "Something went wrong");
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                    ),
                    child: const Text("Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),),
                      TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      }, child:  Text("Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Constant.primaryColor,
                        ),))
                    ],
                  )

                ],
              ),
            ),
          ),
        )
        ,
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text!,
      password: passwordController.text!,
    );
  }
}
void ShowSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.info_outline, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.deepPurple.shade700,  // لون مميز
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 6,
    duration: const Duration(seconds: 4),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
