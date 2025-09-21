// 글 작성 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/tabNavigation/view_models/mood_view_model.dart';

class ArticleWriteScreen extends ConsumerStatefulWidget {
  const ArticleWriteScreen({super.key});

  @override
  ConsumerState createState() => _ArticleWriteScreenState();
}

class _ArticleWriteScreenState extends ConsumerState<ArticleWriteScreen> {
  void _onUploadPressed() {
    ref.read(moodProvider.notifier).uploadMood();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // 업로드 버튼
      child: IconButton(
        onPressed: ref.watch(moodProvider).isLoading ? () {} : _onUploadPressed,
        icon: ref.watch(moodProvider).isLoading
            ? const Icon(Icons.circle_outlined)
            : Icon(Icons.check),
      ),
    );
  }
}
