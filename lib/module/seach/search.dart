import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/state.dart';
import 'package:news_app/shared/componets/compontes.dart';

class searchScreen extends StatelessWidget{
  var seachController=TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var list =NewsCubit.get(context).searchItem;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: seachController,
                  keyboardType: TextInputType.text,

                  decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()
                  ),
                  validator: (String? value){
                    if(value!.isEmpty){return "search must not be empty";}
                    return null;
                  },
                  onChanged: (s){
                    NewsCubit.get(context).getSearch(s);
                  },

                ),
              ),
              Expanded(child: articleBuilder(list, context))
            ],
          ),
        );
      },

    );
  }
}