import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_zain2/Delivery/ShowOrders(done)/bloc/cubit.dart';
import 'package:project_zain2/Delivery/ShowOrders(done)/bloc/status.dart';

class DetailsOrderDone extends StatelessWidget {
  const DetailsOrderDone({super.key, required this.data});
final Data data;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowOrderDoneListCubit(),
      child: BlocConsumer<ShowOrderDoneListCubit,ShowOrderDoneListStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              elevation: 3,
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
                      Text("done",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.green),),
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
}
