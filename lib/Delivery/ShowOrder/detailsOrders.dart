import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Delivery/ShowOrder/bloc/cubit.dart';
import 'package:project_zain2/Delivery/ShowOrder/bloc/status.dart';
import 'package:project_zain2/Delivery/TabBarDelivery/tabBarDeliveryPage.dart'; // Import your AppDrawerDelivery page
import 'package:http/http.dart'as http;
import 'package:project_zain2/utils/shared_prefirance.dart';

import '../../utils/end_point.dart';
class DetailsOrder extends StatelessWidget {
  const DetailsOrder({super.key, required this.data});
final Data data;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShowOrderListCubit(),
      child: BlocConsumer<ShowOrderListCubit, ShowOrderListStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Order Details',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'money amount :${data.order!.totalPrice}\$',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              'number of products :${data.products!.length}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              'date pay :${data.deliveredAt}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.deepOrange),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          _showDoneDialog(context,"${data.order!.id}");
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Done',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(width: 2),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing:
                              10.0, // Spacing between columns
                              mainAxisSpacing:
                              10.0, // Spacing between rows
                              childAspectRatio:
                              2 / 2.3, // Aspect ratio for each item
                            ),
                            itemCount: data.products?.length, // Total number of items
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10.0,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0),
                                        ),
                                        child: Image.network(
                                          '${data.products![index].image}',
                                          // Replace with your image asset
                                          height: 120.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          '${data.products![index].name}',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          '\$${data.products![index].price}.00',
                                          style: const TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
  Future<void> postDoneOrder(BuildContext context,String orderId) async {
    final String apiUrl = '$BASE_URL/api/delivery/orders/$orderId/change_status'; // Replace with your API endpoint
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Add token if needed
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        // Successfully posted
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AppDrawerDelivery(),
          ),
        );
        print('Order marked as done');
      } else {
        print(response.body);

        // Handle the error
        print('Failed to mark order as done: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void _showDoneDialog(BuildContext context,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to mark this order as done?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                postDoneOrder(context,id);

              },
            ),
          ],
        );
      },
    );
  }

}
