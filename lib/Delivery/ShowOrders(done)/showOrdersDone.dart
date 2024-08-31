import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_zain2/Delivery/ShowOrders(done)/bloc/cubit.dart';
import 'package:project_zain2/Delivery/ShowOrders(done)/bloc/status.dart';
import 'package:project_zain2/Delivery/ShowOrders(done)/detailsOrderDone.dart';

class ShowOrdersDone extends StatelessWidget {
   ShowOrdersDone({super.key});
ShowOrdersDoneModel ?showOrdersDoneModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShowOrderDoneListCubit()..getOrders(),
      child: BlocConsumer<ShowOrderDoneListCubit, ShowOrderDoneListStatus>(
        listener: (context, state) {
          if(state is ShowOrderDoneListSuccessStatus)
            showOrdersDoneModel=state.showOrdersDoneModel;

        },
        builder: (context, state) {
          return Scaffold(
            body: showOrdersDoneModel!=null
                ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: 8 / 2, // Aspect ratio for each item
              ),
              itemCount: showOrdersDoneModel!.data?.length, // Total number of items
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsOrderDone(data: showOrdersDoneModel!.data![index],)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(0.0),
                          ),
                          child: Image.asset(
                            'assets/images/b.png',
                            // Replace with your image asset
                            width: 90,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'money amount  \$${showOrdersDoneModel!.data![index].order!.totalPrice}.00',
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 14.0,
                                  ),
                                ),
                                 Text(
                                  'number of products:${showOrdersDoneModel!.data![index].products!.length} ',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 14.0,
                                  ),
                                ),
                                 Text(
                                  '${showOrdersDoneModel!.data![index].deliveredAt}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (index == 9) // Check if it is the last item
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Text("done",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.green),)),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(child: const CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
