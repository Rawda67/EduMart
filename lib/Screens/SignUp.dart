
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import '../Constant.dart';
import 'Login.dart';

bool isLoading=false;

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formKey=GlobalKey();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Constant.backColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Image.asset("assets/SignUp.png",height: 270,),
                Text("Create Account",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Constant.primaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'you must Enter Something!';
                      }else if(value.length<3)
                        return 'Name must be greater than or equal 3 characters';
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        label: const Text(
                          "Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        hintText: 'Enter your name',
                        hintStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.person,
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
                          borderSide: BorderSide(
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

                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if(value!.isEmpty) {
                        return 'you must Enter Something!';
                      }
                      return null;},
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
                            Icons.email,
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
                            color:Constant.errormess,
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

                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'you must Enter Something!';
                      }if (value!.length < 8 || !RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password contains min 8 characters & A special(eg. @ # \$ %)';}
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

                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        await UserRegister();
                        ShowSnackBar(context, "Account Created Successfully. Please verify your email, then log in.");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          ShowSnackBar(context, "The password provided is too weak.");
                        } else if (ex.code == 'email-already-in-use') {
                          ShowSnackBar(context, "The account already exists for that email.");
                        } else {
                          ShowSnackBar(context, ex.message ?? "An unknown error occurred.");
                        }
                      } catch (e) {
                        print("Unexpected error: $e");
                        ShowSnackBar(context, "Something went wrong. Please try again.");
                      }
                      setState(() => isLoading = false);
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
                  child: const Text("Sign up",
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
                    const Text("You already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),),
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }, child:  Text("Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color:Constant.primaryColor,
                      ),))
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
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


  Future<UserCredential> UserRegister() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailController.text!, password: passwordController.text!);
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    return user;
  }
}
