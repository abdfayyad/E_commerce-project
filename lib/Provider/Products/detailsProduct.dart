import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Provider/Products/bloc/cubit.dart';
import 'package:project_zain2/Provider/Products/bloc/status.dart';


class ShowDetailsProducts extends StatelessWidget {
  const ShowDetailsProducts({super.key, required this.data});
final Data data;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowProductsProviderCubit(),
      child: BlocConsumer<ShowProductsProviderCubit,ShowProductsProviderStatus>(
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
                      '${data.image}', // Replace with your image asset
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Product title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Text(
                      '${data.name}',
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
                      '${data.description}',
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
                          'Price: \$${data.price}',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange),
                        ),
                        SizedBox(height: 10.0),
                        // Quantity
                        Text(
                          '${data.productOwnerName}',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange),
                        ),
                        SizedBox(height: 10.0),
                        // Available Colors
                        Text(
                          'Colors:red,green',
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
                  // Center(child: Container(
                  //   height: 50,
                  //   width: 140,
                  //   decoration: BoxDecoration(
                  //     color: Colors.orangeAccent,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(Icons.add_shopping_cart),
                  //           SizedBox(width: 3,),
                  //           Text('add to cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  //         ],
                  //       )),
                  // ),)
                ],
              ),
            ),
          );
        },
      ),

    );

  }
}
