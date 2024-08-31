import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum DrawerPage { products , cart , invoices , profile , deliveries }

class DrawerCubit extends Cubit<DrawerPage> {
  DrawerCubit() : super(DrawerPage.products);

  void selectPage(DrawerPage page) {
    emit(page);
  }
}
