import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/modules/article/article_screen.dart';
import 'package:news_app/shared/style/colors.dart';


Widget buildArticleItem({List<dynamic> articles, context, int index}) {
  return InkWell( onTap: (){
    navigateTo(context, ArticleScreen(title: articles[index]['title'],description: articles[index]['description'],imgUrl: articles[index]['urlToImage'],author: articles[index]['author'],urlaArticle: articles[index]['url'],));
  },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 110,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${articles[index]['urlToImage'].toString()}'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    '${articles[index]['title'].toString()}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Text('${articles[index]['publishedAt'].toString()}',
                      style: TextStyle(
                        color: Colors.grey,fontSize: 16
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget articleBuilder({List list, context, Widget fallBack}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(context: context, index: index, articles: list),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
                height: 0.5,
                width: double.infinity,
                color: Colors.grey,
              ),
        ),
        itemCount: list.length),
    fallback: (context) => fallBack,
  );
}

void navigateTo(context, widget ){
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));
}


Widget defaultFormField(
    {@required TextEditingController controller,
      bool isObs = false,
      @required TextInputType type,
      @required Function validation,
      @required Function sumbite,
      @required Function change,
      String hint,
      Function ontaped,
      double radius = 0.0,
      IconData icon,
      Widget myButton,
      context
      }) {
  var cubit= NewsCubit.get(context);
   return TextFormField(
      obscureText: isObs,
      keyboardType: type,
      onTap: ontaped,
      onChanged: change,
      onFieldSubmitted: sumbite,
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
          // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(radius),
          //     topRight: Radius.circular(radius)) ,
          //   borderSide: BorderSide( width: 1.0,style: BorderStyle.solid),
          // ),
          suffixIcon: myButton,
          hintText: hint,hintStyle: TextStyle(fontFamily: 'Caveat',color: cubit.isDark? darkWhiteDT:Colors.grey),
          prefixIcon: Icon(icon,color: cubit.isDark? darkWhiteDT: Colors.grey,),
          enabledBorder: cubit.isDark? OutlineInputBorder(
              borderSide: BorderSide( width: 1,color: darkWhiteDT),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius),bottomLeft: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius))) : OutlineInputBorder(
              borderSide: BorderSide( width: 1,color: Colors.grey),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius),bottomLeft: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius))) ,
      ),
    );}

