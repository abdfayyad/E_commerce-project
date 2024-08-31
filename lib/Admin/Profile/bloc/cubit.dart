import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Admin/Profile/bloc/status.dart';

class ProfileAdminCubit extends Cubit<ProfileAdminStatus>{
ProfileAdminCubit():super(ProfileAdminInitializeStatus());

}