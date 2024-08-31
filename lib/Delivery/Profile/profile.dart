import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Profile/bloc/cubit.dart';
import 'package:project_zain2/Admin/Profile/bloc/status.dart';
import 'package:project_zain2/Delivery/Profile/bloc/cubit.dart';
import 'package:project_zain2/Delivery/Profile/bloc/status.dart';


class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ProfileDeliveryCubit(),
      child: BlocConsumer<ProfileDeliveryCubit,ProfileDeliveryStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold();
        },
      ),

    );

  }
}
