import 'package:flutter/material.dart';
import 'package:project_zain2/Admin/Percentage/bloc/status.dart';
import 'package:project_zain2/Admin/Percentage/detailsProduct.dart';

class ProductsWithPercentage extends StatelessWidget {
  ProductsWithPercentage({required this.data});


 Data? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body:data!=null?  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child:Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'name: ${data!.name} ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'percentage :${data!.percentage} \$',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  Text(
                    'Email :${data!.email} ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                  Text(
                    'phone number :${data!.phoneNumber} ',
                    style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                  ),
                ],
              ),
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
                  child:Padding(
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
                      itemCount: data!.produncts?.length??0, // Total number of items
                      itemBuilder:
                          (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDetailsProducts(products: data!.produncts![index],per: data!.percentage!,)));
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
                                    '${data?.produncts![index].image}',
                                    // Replace with your image asset
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '${data!.produncts![index].name}',
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
                                  child: Text(
                                    '\$${data?.produncts![index].price}.00',
                                    style:const TextStyle(
                                      color:
                                      Colors.deepOrange,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '${data!.percentage}',
                                    style:const TextStyle(
                                      color:
                                      Colors.deepOrange,
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold,
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
                  )
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ):Container(),
    );
  }
}
