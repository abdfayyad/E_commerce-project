

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/All/Login/login.dart';
import 'package:project_zain2/Client/App_drawer/app_dawer.dart';
import 'package:project_zain2/Client/Signup/bloc/cubit.dart';
import 'package:project_zain2/Client/Signup/bloc/status.dart';

import '../../utils/shared_prefirance.dart';



class SignUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
SignInModel? signInModel;
  @override
  Widget build(BuildContext context) {
    TextEditingController userFirstNameController = TextEditingController();
    TextEditingController userLastNameController = TextEditingController();
    TextEditingController userAddressController = TextEditingController();
    TextEditingController emailAddressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController genderController= TextEditingController();
    bool showPass = true;

    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInScreenStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
             signInModel=state.signInModel;
             SharedPref.saveData(key: 'token', value: state.signInModel.token)
                 .then((value) {
               print(SharedPref.getData(key: 'token'));
             });
             SharedPref.saveData(key: 'role', value: state.signInModel.role)
                 .then((value) {
               print(SharedPref.getData(key: 'token'));
             });
             Navigator.pushReplacement(context,
                 MaterialPageRoute(builder: (context) => AppDrawerClient()));
          }
          if (state is SignInErrorState) {
            Flushbar(
                titleText: Text("error sign in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.deepPurple, fontFamily:"ShadowsIntoLightTwo"),),
                messageText: Text("you email as taken ", style: TextStyle(fontSize: 16.0, color: Colors.deepPurple),),
                duration:  Duration(seconds: 3),
                backgroundColor: Colors.red,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8)

            ).show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SingIn'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: userFirstNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User First Name Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: ' User first name',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User first Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: userLastNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User Last Name Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: ' User Last name',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User Last Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: userAddressController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter User address Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: ' User Address',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: 'Enter User Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Phone Number Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'phoneNumber',
                                prefixIcon: Icon(
                                  Icons.phone,
                                ),
                                hintText: 'Enter Phone Number',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            controller: emailAddressController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Email Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: 'Enter Email Address',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },

                          obscureText: SignInCubit.get(context)
                              .isPasswordShow, //isPasswordShow,
                          decoration: InputDecoration(
                              labelText: 'password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  SignInCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(SignInCubit.get(context).suffix),
                              ),
                              hintText: 'Enter Your Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                            controller: genderController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your gender Please';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'gender',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: 'Enter your gender',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0)))),
                        const SizedBox(
                          height: 30.0,
                        ),

                          MaterialButton(
                            onPressed: () {
                              SignInCubit.get(context).loginUser(
                              "${userFirstNameController.text} ${userLastNameController.text}",
                              emailAddressController.text,
                              passwordController.text,
                              phoneNumberController.text,
                              genderController.text,
                              userAddressController.text
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              height: 40.0,
                              width: 100.0,
                              child: Center(
                                  child: Text('SING_UP', style: TextStyle())),
                            ),


                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Alreadyhaveanaccount'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.red,
                                ),
                                onPressed: () {}),
                            const SizedBox(
                              width: 30.0,
                            ),
                            IconButton(
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {}),
                            const SizedBox(
                              width: 30.0,
                            ),
                            IconButton(
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}