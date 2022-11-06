import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/style/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = TextEditingController();
    return BlocConsumer<NewsCubit,NewsStates>(
      builder:(context, state) {
        return Scaffold(appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: defaultFormField(radius: 5,context: context,controller: text, hint: 'write something to search',type: TextInputType.text,validation: (String value){
                  if (value.isEmpty)
                  {return 'search must not be empty';}
                  else return null;
                },
                    icon: Icons.search, change: (String value){
                      NewsCubit.get(context).getSearchData(value);
                    } ),
              ),
              Expanded(child: articleBuilder(context: context,list: NewsCubit.get(context).search,fallBack: Center(child: Text('Nothing to show',style: NewsCubit.get(context).isDark ? TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: darkWhiteDT): TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.grey))),)
              )],
          ),);
      } ,
      listener: (context, state) {
      },
    );
  }
}
