import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/All/Login/login.dart';
import 'package:project_zain2/Client/App_drawer/bloc/cubit.dart';
import 'package:project_zain2/Client/Cart/showCart.dart';
import 'package:project_zain2/Client/Invoices/showInvoices.dart';
import 'package:project_zain2/Client/Products/showProducts.dart';
import 'package:project_zain2/Client/Profile/profile.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';


class AppDrawerClient extends StatelessWidget {
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
            } else if (state == DrawerPage.cart) {
              return ShowCart();
            }
            else if (state == DrawerPage.invoices) {
              return ShowInvoices();
            }
            else if (state == DrawerPage.profile) {
              return ProfileClient();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<DrawerCubit, DrawerPage>(
        builder: (context, state) {
          return ListView(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.orangeAccent),
                accountName: Text(
                  "welcome in our application",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "welcome 😍",
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
                selected: state == DrawerPage.products,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.products);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('cart'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.cart,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.cart);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart_outlined),
                title: Text('invoices'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.invoices,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.invoices);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('profile'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.profile,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.profile);
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
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}


