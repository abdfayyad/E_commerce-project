import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Client/Profile/bloc/status.dart';
import 'package:project_zain2/Provider/Profile/bloc/status.dart';

class ProfileProviderCubit extends Cubit<ProfileProviderStatus>{
ProfileProviderCubit():super(ProfileProviderInitializeStatus());

}