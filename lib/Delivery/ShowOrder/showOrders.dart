import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Delivery/ShowOrder/bloc/cubit.dart';
import 'package:project_zain2/Delivery/ShowOrder/bloc/status.dart';
import 'package:project_zain2/Delivery/ShowOrder/detailsOrders.dart';

class ShowOrders extends StatelessWidget {
   ShowOrders({super.key});
ShowOrderListModel ?showOrderListModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowOrderListCubit()..getDeliveries(),
    child: BlocConsumer<ShowOrderListCubit,ShowOrderListStatus>(
      listener: (context,state){
        if(state is ShowOrderListSuccessStatus)
          showOrderListModel=state.showOrderListModel;
      },
      builder: (context,state){
        return Scaffold(
          body: showOrderListModel!=null
              ? GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Number of columns
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
              childAspectRatio: 8 / 2, // Aspect ratio for each item
            ),
            itemCount: showOrderListModel!.data!.length, // Total number of items
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsOrder(data: showOrderListModel!.data![index],)));
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
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
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'money amount  \$${showOrderListModel!.data![index].order!.totalPrice}.00',
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                'Status of order:${showOrderListModel!.data![index].products!.length}.  ',
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                '${showOrderListModel!.data![index].deliveredAt}.',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
              : Center(child: CircularProgressIndicator()),
        );
      },
    ),
    );
  }
}
