// 글 보여주는 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/tabNavigation/view_models/mood_view_model.dart';

class ArticleShowScreen extends ConsumerStatefulWidget {
  const ArticleShowScreen({super.key});

  @override
  ConsumerState createState() => _ArticleShowScreenState();
}

class _ArticleShowScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return ref
        .watch(moodProvider)
        .when(
          data: (moodList) {
            return ListView.builder(
              itemCount: moodList.length,
              itemBuilder: (context, index) {
                final mood = moodList[index];
                return ListTile(title: Text(mood.title));
              },
            );
          },
          error: (error, StackTrace) => Center(child: Text('$error')),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
