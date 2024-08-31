import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Deliveries/showDeliveries.dart';
import 'package:project_zain2/Admin/Orders/showOrdersRequests.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_zain2/Admin/App_drawer/bloc/cubit.dart';
import 'package:project_zain2/Admin/Percentage/percentage_providers.dart';
import 'package:project_zain2/Admin/Providers/showPoviders.dart';
import 'package:project_zain2/Admin/Purchases/show_purchases.dart';
import 'package:project_zain2/Admin/Products/showProducts.dart';
import 'package:project_zain2/All/Login/login.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';

class AppDrawerAdmin extends StatelessWidget {
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
              return ShowProducts();
            } else if (state == DrawerPage.purchases) {
              return ShowPurchases();
            }
            else if (state == DrawerPage.orderRequests) {
              return ShowOrdersRequests();
            }
            else if (state == DrawerPage.percentage) {
              return PercentageProviderScreen();
            }
            else if (state == DrawerPage.providers) {
              return ShowProviders();
            }
            else if (state == DrawerPage.deliveries) {
              return ShowDeliveries();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
class AdminInfo {
  final String name;
  final String email;

  AdminInfo({required this.name, required this.email});

  factory AdminInfo.fromJson(Map<String, dynamic> json) {
    return AdminInfo(
      name: json['name'],
      email: json['email'],
    );
  }
}


Future<AdminInfo> fetchDeliveryInfo() async {
  final response = await http.get(
      Uri.parse('$BASE_URL/api/admin/profile'),
    headers: {
  'Accept': 'application/json',
  'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
  },
  );

  if (response.statusCode == 200) {
    return AdminInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load delivery information');
  }
}
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Future<AdminInfo> futureDeliveryInfo;

  @override
  void initState() {
    super.initState();
    futureDeliveryInfo = fetchDeliveryInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<AdminInfo>(
        future: futureDeliveryInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final adminInf = snapshot.data!;
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.orangeAccent),
                  accountName: Text(
                    adminInf.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    adminInf.email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: FlutterLogo(),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Products'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.products,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.products);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Purchases'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.purchases,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.purchases);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Order requests'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.orderRequests,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.orderRequests);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.percent),
                  title: Text('Percentage'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.percentage,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.percentage);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Providers'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.providers,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.providers);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.local_shipping),
                  title: Text('Deliveries'),
                  selectedColor: Colors.deepOrange,
                  selected: context.read<DrawerCubit>().state == DrawerPage.deliveries,
                  onTap: () {
                    context.read<DrawerCubit>().selectPage(DrawerPage.deliveries);
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
