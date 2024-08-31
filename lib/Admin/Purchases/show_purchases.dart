import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Purchases/bloc/cubit.dart';
import 'package:project_zain2/Admin/Purchases/bloc/status.dart';
import 'package:project_zain2/Admin/Purchases/invoice.dart';

class ShowPurchases extends StatelessWidget {
   ShowPurchases({super.key});
ShowPurchasesModel? showPurchasesModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowPurchasesAdminCubit()..getPurchases(),
      child: BlocConsumer<ShowPurchasesAdminCubit,ShowPurchasesAdminStatus>(
        listener: (context,state){
          if(state is ShowPurchasesAdminSuccessStatus)
            showPurchasesModel=state.showPurchasesModel;
        },
        builder: (context,state){
          return Scaffold(

            body: showPurchasesModel!=null
                ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
                childAspectRatio: 8 / 2, // Aspect ratio for each item
              ),
              itemCount: showPurchasesModel?.data?.length, // Total number of items
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsInvoice(data: showPurchasesModel!.data![index],)));
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
                        SizedBox(width: 15,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${showPurchasesModel!.data![index].personName}',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                                Text(
                                  'money amount  \$${showPurchasesModel!.data![index].moneyAmount}.00',
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 14.0,

                                  ),
                                ),
                                Text(
                                  'number of products:${showPurchasesModel!.data![index].numberOfProducts} ',
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 14.0,

                                  ),
                                ),
                                Text(
                                  '${showPurchasesModel!.data![index].purchaseDate}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,

                                  ),
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
