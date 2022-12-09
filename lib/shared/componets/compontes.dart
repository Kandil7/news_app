
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../module/webview/webview.dart';

Widget newsItem({required Map news,context}) {
  return InkWell(
    onTap: (){
      navigateTo(context, Webview(news['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage("${news['urlToImage'] != null ? news['urlToImage'] :null}"),
                    //'https://www.elaosboa.com/wp-content/uploads/2022/03/elaosboa73691.jpg'
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: Text(
                      "${news['title']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${news['publishedAt']}",
                    style: TextStyle(color: Colors.grey[700]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[600],
  );
}
BlocConsumer<NewsCubit, NewsState> articleBuilder(list,context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: list.length>0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => newsItem(
                    news:list[index],context: context
                  ),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount:list.length,
                ),
            fallback: (context)=> Center(child: CircularProgressIndicator()));
      });
  }
  void navigateTo(BuildContext context,Widget widget)=>Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));
