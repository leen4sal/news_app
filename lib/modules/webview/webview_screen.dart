import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  String url;

  WebviewScreen({this.url});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
        body: WebView(initialUrl: url,),),
      );
    }, listener: (context, state) {

    },);
  }
}
