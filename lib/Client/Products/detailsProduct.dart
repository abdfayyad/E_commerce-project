import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Products/bloc/cubit.dart';
import 'package:project_zain2/Admin/Products/bloc/status.dart';
import 'package:project_zain2/Client/Products/bloc/cubit.dart';
import 'package:project_zain2/Client/Products/bloc/status.dart';
import 'package:http/http.dart'as http;
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';

class ShowDetailsProducts extends StatelessWidget {
  const ShowDetailsProducts({super.key, required this.products});
final Products products;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowProductsClientCubit()..getProducts(),
      child: BlocConsumer<ShowProductsClientCubit,ShowProductsClientStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Product Details",
                style: TextStyle(color: Colors.deepOrange),
              ),

            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '${products.image}', // Replace with your image asset
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Product title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Text(
                      '${products.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.deepOrange),
                    ),
                  ),
                  // Product description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${products.description}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  // Price, Quantity, Available Colors, Availability
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price
                        Text(
                          'Price: \$${products.price}',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange),
                        ),
                        SizedBox(height: 10.0),
                        // Quantity
                        Text(
                          ' ${products.createdAt}',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange),
                        ),
                        SizedBox(height: 10.0),
                        // Available Colors
                        Text(
                          'Available Colors: red,green',
                          style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10.0),
                        // Availability
                        Text(
                          'Availability: In Stock',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(child: InkWell(
                    onTap: (){
                      addToCart(context,"${products.id}");
                    },
                    child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_shopping_cart),
                              SizedBox(width: 3,),
                              Text('add to cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            ],
                          )),
                    ),
                  ),)
                ],
              ),
            ),
          );
        },
      ),

    );

  }
}

Future<void> addToCart(BuildContext context, String id,) async {
  final String url = '$BASE_URL/api/client/cart/add-product/$id';
print(url);
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',  // If authentication is required
      },

    );

    if (response.statusCode == 200) {
      // Successful response
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added successfully!')));
      print('Order $id assigned to delivery successfully.');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add Product !')));
      print(response.body);
      // Error response
      print('Failed ,Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions
    print('Exception occurred: $e');
  }
}