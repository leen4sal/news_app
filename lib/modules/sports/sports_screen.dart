import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/status.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder:(context, state) {
        var list =NewsCubit.get(context).sports;
        return  articleBuilder(list: list,context: context,fallBack: Center(child: CircularProgressIndicator()));
      } ,
      listener: (context, state) {
      },
    );
  }
}
