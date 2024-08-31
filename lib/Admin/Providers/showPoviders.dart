import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:project_zain2/Admin/Providers/bloc/cubit.dart';
import 'package:project_zain2/Admin/Providers/bloc/status.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';

import '../App_drawer/app_dawer.dart';

class ShowProviders extends StatelessWidget {
  ShowProviders({Key? key}) : super(key: key);
  ShowProvidersModel? showProvidersModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShowProvidersCubit()..getProviders(),
      child: BlocConsumer<ShowProvidersCubit, ShowProviderStatus>(
        listener: (context, state) {
          if (state is ShowProviderSuccessStatus) {
            showProvidersModel = state.showProvidersModel;
          }
        },
        builder: (context, state) {
          return showProvidersModel != null
              ? Scaffold(
                  appBar: AppBar(
                    title: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group),
                          SizedBox(
                            width: 3,
                          ),
                          Text('Providers'),
                        ],
                      )),
                    ),
                  ),
                  body: ListView.builder(
                    itemCount: showProvidersModel?.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              "${showProvidersModel!.data![index].name!.substring(0, 1)}",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.deepOrange,
                          ),
                          title:
                              Text("${showProvidersModel!.data![index].name}"),
                          subtitle:
                              Text("${showProvidersModel!.data![index].email}"),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ProvidersDetailsDialog(
                                    provider: showProvidersModel!.data![index]);
                              },
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text(
                                        'Do you want to delete this Provider?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteProvider(context,
                                              "${showProvidersModel!.data![index].id}");
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ));
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddProvidersDialog();
                        },
                      );
                    },
                    child: Icon(Icons.add),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ProvidersDetailsDialog extends StatelessWidget {
  final Data provider;

  const ProvidersDetailsDialog({required this.provider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Provider Details'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${provider.name}'),
            Text('Email: ${provider.email}'),
            Text('Gender: ${provider.gender}'),
            Text('Percentage: ${provider.percentage}'),

            // Add other provider details here if available
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class AddProvidersDialog extends StatefulWidget {
  @override
  _AddProvidersDialogState createState() => _AddProvidersDialogState();
}

class _AddProvidersDialogState extends State<AddProvidersDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose controllers to free resources
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    genderController.dispose();
    phoneNumberController.dispose();
    percentageController.dispose();

    super.dispose();
  }

  Future<void> _addProvider() async {
    if (!_formKey.currentState!.validate()) {
      // If the form is not valid, display a Snackbar or some error message
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var name = nameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var address = addressController.text.trim();
    var gender = genderController.text.trim();
    var phoneNumber = phoneNumberController.text.trim();
    var percentage = percentageController.text.trim();

    // Debugging prints
    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
    print('Address: $address');
    print('Gender: $gender');
    print('Phone Number: $phoneNumber');
    print('percentage $percentage');

    try {
      await addProvider(
        name: name,
        email: email,
        password: password,
        address: address,
        gender: gender,
        phoneNumber: phoneNumber,
        percentage: percentage,
        context: context,
      );
    } catch (e) {
      // Display an error message to the user
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Provider'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the name.';
                  }
                  return null;
                },
              ),
              // Email Field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the email.';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
              ),
              // Password Field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the password.';
                  }
                  if (value.trim().length < 6) {
                    return 'Password should be at least 6 characters.';
                  }
                  return null;
                },
              ),
              // Address Field
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the address.';
                  }
                  return null;
                },
              ),
              // Gender Field
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the gender.';
                  }
                  return null;
                },
              ),
              // Phone Number Field
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the phone number.';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                    return 'Please enter a valid phone number.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: percentageController,
                decoration: InputDecoration(labelText: 'Percentage '),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the Percentage.';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _addProvider,
          child: _isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text('Add'),
        ),
      ],
    );
  }
}

Future<void> deleteProvider(BuildContext context, String id) async {
  final String url = '$BASE_URL/api/admin/providers/$id'; // Replace with your API endpoint
  print(id);
  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        // If your API requires authentication
      },
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AppDrawerAdmin()),
          (Route<dynamic> route) => false);

      // If the server did delete the product successfully
      print(response.body);
    } else {
      print(response.body);

      // If the server did not delete the product successfully
      print(
          'Failed to delete the product. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred while deleting the product: $e');
  }
}

Future<void> addProvider({
  required String name,
  required String email,
  required String password,
  required String address,
  required String gender,
  required String phoneNumber,
  required String percentage,
  required BuildContext context,
}) async {
  final url = Uri.parse('$BASE_URL/api/admin/providers');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'gender': gender,
      'phone_number': phoneNumber,
      'percentage': percentage
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Response Body: ${response.body}');
    // Navigate to the desired page after successful addition
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AppDrawerAdmin()),
        (Route<dynamic> route) => false);

    // Inform the user of the successful addition
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Provider added successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // You might want to refresh the provider list here
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    print('Error Response Body: ${response.body}');
    // Decode the error message from the server
    var errorData = jsonDecode(response.body);
    var errorMessage = errorData['message'] ?? 'Failed to add provider.';
    throw Exception(errorMessage);
  }
}
