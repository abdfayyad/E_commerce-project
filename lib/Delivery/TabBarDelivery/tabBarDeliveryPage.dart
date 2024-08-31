import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/All/Login/login.dart';
import 'package:project_zain2/Delivery/ShowOrder/showOrders.dart';
import 'package:project_zain2/Delivery/ShowOrders(done)/showOrdersDone.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_zain2/Delivery/TabBarDelivery/bloc/cubit.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
class AppDrawerDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrawerCubit>(
      create: (context) => DrawerCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(
            'E _Com',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        drawer: DrawerWidget(), // This DrawerWidget now has access to DrawerCubit
        body: BlocBuilder<DrawerCubit, DrawerPage>(
          builder: (context, state) {
            if (state == DrawerPage.products) {
              return ShowOrders();
            } else if (state == DrawerPage.cart) {
              return ShowOrdersDone();
            }
            
            return Container();
          },
        ),
      ),
    );
  }
}
Future<DeliveryInfo> fetchDeliveryInfo() async {
  final response = await http.get(Uri.parse('$BASE_URL/api/delivery/profile'),
    headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
  },);

  if (response.statusCode == 200) {
    return DeliveryInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load delivery information');
  }
}

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}
class DeliveryInfo {
  final String name;
  final String email;

  DeliveryInfo({required this.name, required this.email});

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      name: json['name'],
      email: json['email'],
    );
  }
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Future<DeliveryInfo> futureDeliveryInfo;

  @override
  void initState() {
    super.initState();
    futureDeliveryInfo = fetchDeliveryInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<DeliveryInfo>(
        future: futureDeliveryInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final deliveryInfo = snapshot.data!;
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.orangeAccent),
                  accountName: Text(
                    deliveryInfo.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    deliveryInfo.email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: FlutterLogo(),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Orders'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.products,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.products);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Orders done'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.cart,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.cart);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  selectedColor: Colors.deepOrange,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                SharedPref.removeData(key: 'token');
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                        (Route<dynamic> route) => false);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}



