import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Percentage/Products_With_percentage.dart';
import 'package:project_zain2/Admin/Percentage/bloc/cubit.dart';
import 'package:project_zain2/Admin/Percentage/bloc/status.dart';
class PercentageProviderScreen extends StatelessWidget {
  PercentageProviderScreen({super.key});

  PercentageModel? percentageModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PercentageProvidersCubit()..getPercentageProvider(),
      child: BlocConsumer<PercentageProvidersCubit, PercentageProvidersStatus>(
        listener: (context, state) {
          if (state is PercentageProvidersSuccessStatus) {
            percentageModel = state.percentageModel;
          } else if (state is PercentageProvidersErrorStatus) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load data')));
          }
        },
        builder: (context, state) {
          if (state is PercentageProvidersLoadingStatus) {
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: percentageModel != null
                ? ListView.builder(
              itemCount: percentageModel!.data?.length ?? 0,
              itemBuilder: (context, index) {
                final provider = percentageModel!.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsWithPercentage(data: provider)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ima.png'),
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.name ?? 'No Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(provider.email ?? 'No Email'),
                                Text(provider.phoneNumber ?? 'No Phone'),
                                Text('${provider.produncts?.length ?? 0} products'),
                                Text('percentage ${provider.percentage}')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : Center(child: Text('No data available')),
          );
        },
      ),
    );
  }
}

