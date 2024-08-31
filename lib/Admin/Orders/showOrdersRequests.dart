import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/App_drawer/app_dawer.dart';
import 'package:project_zain2/Admin/Orders/bloc/cubit.dart';
import 'package:project_zain2/Admin/Orders/bloc/status.dart';
import 'package:http/http.dart' as http;
import 'package:project_zain2/Admin/Percentage/percentage_providers.dart';
import 'dart:convert';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
class ShowOrdersRequests extends StatelessWidget {
   ShowOrdersRequests({super.key});
ShowOrderAdminModel ?showOrderAdminModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShowOrderAdminCubit()..getOrders(),
      child: BlocConsumer<ShowOrderAdminCubit, ShowOrderAdminStatus>(
        listener: (context, state) {
          if(state is ShowOrderAdminSuccessStatus)
            showOrderAdminModel=state.showOrderAdminModel;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PercentageProviderScreen()));
                },
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list_alt),
                        SizedBox(width: 3),
                        Text('Orders'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: showOrderAdminModel!=null
                ? ListView.builder(
              itemCount: showOrderAdminModel!.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        // Navigate to order details screen or expand the tile
                        // Based on your preference
                      },
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/b.png'),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      title: Text('Number of Products:${showOrderAdminModel!.data![index].numberOfProducts}'),
                      subtitle:
                      Text('Name: ${showOrderAdminModel!.data![index].clientName}\nTotal Amount: \$${showOrderAdminModel!.data![index].totalPrice}'),
                      trailing: TextButton(
                        onPressed: () {
                          // Show delivery list dialog
                          _showDeliveryListDialog(context,"${showOrderAdminModel!.data![index].id}");
                        },
                        child: Text(
                          'charge',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    ),
                    // Add an ExpansionTile to show details when tapped
                    ExpansionTile(
                      title: Text('Order Details'),
                      children: [
                        SizedBox(
                          height: 500,
                          child: GridView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                              2, // Number of columns
                              crossAxisSpacing:
                              10.0, // Spacing between columns
                              mainAxisSpacing:
                              10.0, // Spacing between rows
                              childAspectRatio:
                              2 / 2.3, // Aspect ratio for each item
                            ),
                            itemCount: showOrderAdminModel!.data![index].products!.length, // Total number of items
                            itemBuilder:
                                (BuildContext context, int indexx) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(15.0),
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
                                        '${showOrderAdminModel!.data![index].products![indexx].productImage}',
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
                                        '${showOrderAdminModel!.data![index].products![indexx].productName}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            '\$${showOrderAdminModel!.data![index].products![indexx].productPrice}.00',
                                            style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton
                                                  .styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                Colors.deepPurple,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10.0),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}


// Function to fetch delivery data from API
Future<List<Map<String, dynamic>>> fetchDeliveryData() async {
  final response = await http.get(Uri.parse('$BASE_URL/api/admin/deliveries/free_deliveries'),headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
  }); // Replace with your API endpoint

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<Map<String, dynamic>> deliveries = List<Map<String, dynamic>>.from(data['avaliable_deliveries']);
    print(deliveries);
    return deliveries;
  } else {
    print(response.body);
    throw Exception('Failed to load delivery data');
  }
}


// Function to show delivery list dialog
void _showDeliveryListDialog(BuildContext context,String idOrder) {
  int deliveryID;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDeliveryData(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
              title: Text('Select Deliveries'),
              content: Container(
                width: double.maxFinite,
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to load deliveries.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            );
          } else {
            List<Map<String, dynamic>> deliveries = snapshot.data!;
            return AlertDialog(
              title: Text('Select Deliveries'),
              content: Container(
                width: double.maxFinite,
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: deliveries.length,
                  itemBuilder: (BuildContext context, int index) {
                    deliveryID=deliveries[index]["id"];
                    return ListTile(
                      title: Text(deliveries[index]['name']),
                      subtitle: Text(deliveries[index]['email']),
                      onTap: () {
                        postOrderToDelivery(context,idOrder ,"${deliveryID}");
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            );
          }
        },
      );
    },
  );
}

Future<void> postOrderToDelivery(BuildContext contextt,String orderId, String deliveryId) async {
  final String url = '$BASE_URL/api/admin/orders/$orderId/to/delivery/$deliveryId';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      },
      body: jsonEncode(<String, dynamic>{
        // Add any required body parameters here
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          contextt,
          MaterialPageRoute(builder: (context) => AppDrawerAdmin()),
              (Route<dynamic> route) => false);
      // Successful response
print(response.body);
      print('Order $orderId assigned to delivery $deliveryId successfully.');
    } else {
      print(response.body);
      // Error response
      print('Failed to assign order $orderId to delivery $deliveryId. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.pushAndRemoveUntil(
          contextt,
          MaterialPageRoute(builder: (context) => AppDrawerAdmin()),
              (Route<dynamic> route) => false);
    }
  } catch (e) {
    // Handle any exceptions
    print('Exception occurred: $e');
  }
}