import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/modules/webview/webview_screen.dart';
import 'package:news_app/shared/components/components.dart';

class ArticleScreen extends StatelessWidget {
  String title; String description; String imgUrl; String author; String urlaArticle;
   ArticleScreen({this.title, this.description, this.imgUrl, this.author, this.urlaArticle});


  @override
  Widget build(BuildContext context2) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },builder: (context, state) {
        int index;
        // var cubit=NewsCubit.get(context);
        return Scaffold(appBar: AppBar(),body:
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Text('$title',style: Theme.of(context).textTheme.headline1 ,textAlign: TextAlign.justify,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image(image: NetworkImage('$imgUrl'),width: 250,height: 200,fit: BoxFit.cover,),
            ),
            AutoSizeText('$description',style: Theme.of(context).textTheme.bodyText2 ,maxFontSize: 24,minFontSize:14 ,overflow: TextOverflow.ellipsis,maxLines: 9,stepGranularity: 2,textAlign: TextAlign.justify,),
            Row(
              children: [
                AutoSizeText('Author: $author',style: TextStyle(fontSize: 10,color: Colors.grey,),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextButton(onPressed: (){
                 navigateTo(context, WebviewScreen(url: urlaArticle,));
              }, child: Text('open web page')),
            )
          ],),
        ),);
      },
    );
  }
}
