import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_zain2/Provider/Profile/bloc/cubit.dart';
import 'package:project_zain2/Provider/Profile/bloc/status.dart';


class ProfileProvider extends StatelessWidget {
  const ProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ProfileProviderCubit(),
      child: BlocConsumer<ProfileProviderCubit,ProfileProviderStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold();
        },
      ),

    );

  }
}
