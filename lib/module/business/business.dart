// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';

import 'package:news_app/cubit/state.dart';

import '../../shared/componets/compontes.dart';

class Business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).businessNews;

    return articleBuilder(list,context);
  }
}
