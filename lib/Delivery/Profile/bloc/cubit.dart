import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zain2/Delivery/Profile/bloc/status.dart';

class ProfileDeliveryCubit extends Cubit<ProfileDeliveryStatus>{
ProfileDeliveryCubit():super(ProfileDeliveryInitializeStatus());

}