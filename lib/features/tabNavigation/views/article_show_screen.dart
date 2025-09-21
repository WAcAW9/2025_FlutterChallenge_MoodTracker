// 글 보여주는 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/features/articles/view_models/article_view_model.dart';

class ArticleShowScreen extends ConsumerStatefulWidget {
  const ArticleShowScreen({super.key});

  @override
  ConsumerState createState() => _ArticleShowScreenState();
}

class _ArticleShowScreenState extends ConsumerState<ArticleShowScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(articlesProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(articlesProvider)
        .when(
          data: (articleList) {
            return ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (context, index) {
                final article = articleList[index];
                // int 타입의 타임스탬프를 DateTime 객체로 변환
                final DateTime articleDate =
                    DateTime.fromMillisecondsSinceEpoch(article.date);
                final String formattedDate = DateFormat(
                  'yyyy년 MM월 dd일',
                ).format(articleDate);
                return ListTile(
                  title: Text(article.mood),
                  subtitle: Column(
                    children: [Text(article.description), Text(formattedDate)],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete), // 삭제 아이콘 추가
                    onPressed: () {
                      // 삭제 확인 다이얼로그
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("삭제"),
                            content: const Text("정말 이 글을 삭제하시겠습니까?"),
                            actions: [
                              TextButton(
                                child: const Text("취소"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: const Text("삭제"),
                                onPressed: () async {
                                  // 삭제 로직
                                  await ref
                                      .read(articlesProvider.notifier)
                                      .deleteArticle(article.id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
          error: (error, StackTrace) => Center(child: Text('$error')),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
