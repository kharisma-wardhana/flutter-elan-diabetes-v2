import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../domain/entities/article_entity.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../widget/base_page.dart';
import '../cubit/article_cubit.dart';
import '../cubit/article_state.dart';

class ListArticlePage extends StatefulWidget {
  const ListArticlePage({super.key});

  @override
  State<ListArticlePage> createState() => _ListArticlePageState();
}

class _ListArticlePageState extends State<ListArticlePage> {
  final navigatorHelper = sl<AppNavigator>();
  final ArticleCubit articleCubit = sl<ArticleCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Informasi Diabetes'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.h,
            color: Colors.white,
          ),
          onPressed: () async {
            navigatorHelper.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<ArticleCubit, ArticleState>(
                builder: (context, state) {
                  if (state.articleState.status.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state.articleState.status.isError) {
                    return const Center(child: Text('Error'));
                  }
                  return Column(
                    children: (state.articleState.data as List<ArticleEntity>)
                        .asMap()
                        .entries
                        .map(
                          (e) => ListTile(
                            tileColor: e.key % 2 == 0
                                ? ColorName.lightGrey
                                : ColorName.white,
                            title: Text(e.value.title),
                            onTap: () {
                              navigatorHelper.pushNamed(
                                detailArticlePage,
                                arguments: e.value,
                              );
                            },
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 30.h,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
