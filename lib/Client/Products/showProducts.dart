import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_zain2/Client/Products/bloc/cubit.dart';
import 'package:project_zain2/Client/Products/bloc/status.dart';
import 'package:project_zain2/Client/Products/detailsProduct.dart';
import 'package:project_zain2/utils/end_point.dart';
import 'package:project_zain2/utils/shared_prefirance.dart';
import 'package:http/http.dart'as http;

class ShowProducts extends StatelessWidget {
   ShowProducts({super.key});
  final TextEditingController _searchController = TextEditingController();
ShowProductsModel? showProductsModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowProductsClientCubit()..getProducts(),
      child: BlocConsumer<ShowProductsClientCubit,ShowProductsClientStatus>(
        listener: (context,state){
          if(state is ShowProductsClientSuccessStatus)
            showProductsModel=state.showProductsModel;
        },
        builder: (context,state){
          return Scaffold(
            body:showProductsModel!=null? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Expanded(
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
                      itemCount: showProductsModel!.products!.length, // Total number of items
                      itemBuilder:
                          (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDetailsProducts(products: showProductsModel!.products![index],)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(15.0),
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
                                    topLeft:
                                    Radius.circular(15.0),
                                    topRight:
                                    Radius.circular(15.0),
                                  ),
                                  child: Image.network(
                                    '${showProductsModel!.products![index].image}',
                                    // Replace with your image asset
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '${showProductsModel!.products![index].name}',
                                    style:const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        '\$${showProductsModel!.products![index].price}.00',
                                        style:const TextStyle(
                                          color:
                                          Colors.deepOrange,
                                          fontSize: 16.0,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ElevatedButton(
                                          style: ElevatedButton
                                              .styleFrom(
                                            padding:
                                            EdgeInsets.zero,
                                            backgroundColor:
                                            Colors.deepOrange,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            addToCart(context,"${showProductsModel!.products![index].id}");
                                          },
                                          child:const Icon(
                                            Icons
                                                .add_shopping_cart,
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ):Center(child: CircularProgressIndicator(),),

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