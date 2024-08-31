import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Provider/Products/add_product.dart';
import 'package:project_zain2/Provider/Products/bloc/cubit.dart';
import 'package:project_zain2/Provider/Products/bloc/status.dart';
import 'package:project_zain2/Provider/Products/detailsProduct.dart';
class ShowProducts extends StatelessWidget {
   ShowProducts({super.key});
   ProductsProviderModel?productsProviderModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowProductsProviderCubit()..getProducts(),
      child: BlocConsumer<ShowProductsProviderCubit,ShowProductsProviderStatus>(
        listener: (context,state){
          if(state is ShowProductsProviderSuccessStatus)
            productsProviderModel=state.productsProviderModel;
        },
        builder: (context,state){
          return Scaffold(
            body:productsProviderModel!=null? Column(
              children: [
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
                      itemCount: productsProviderModel!.data?.length, // Total number of items
                      itemBuilder:
                          (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDetailsProducts(data: productsProviderModel!.data![index],)));
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
                                    '${productsProviderModel!.data![index].image}',
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
                                    '${productsProviderModel!.data![index].name}',
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
                                        '\$${productsProviderModel!.data![index].price}.00',
                                        style:const TextStyle(
                                          color:
                                          Colors.deepOrange,
                                          fontSize: 16.0,
                                          fontWeight:
                                          FontWeight.bold,
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
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddProductScreen()));
                },
                backgroundColor: Colors.orange
            ),
          );
        },
      ),

    );

  }
}
