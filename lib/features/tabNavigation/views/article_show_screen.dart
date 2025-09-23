// 글 보여주는 스크린
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/features/articles/view_models/article_view_model.dart';
import 'package:mood_tracker/features/constants/gaps.dart';

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
            articleList.sort((a, b) => b.date.compareTo(a.date));
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size32,
              ),
              itemCount: articleList.length,
              itemBuilder: (context, index) {
                final article = articleList[index];
                final DateTime articleDate =
                    DateTime.fromMillisecondsSinceEpoch(article.date);
                final String formattedDate = DateFormat(
                  'yyyy년 MM월 dd일',
                ).format(articleDate);
                return Padding(
                  padding: const EdgeInsets.only(bottom: Sizes.size10),
                  child: Material(
                    elevation: 5, // 그림자의 깊이
                    shadowColor: Colors.black.withOpacity(0.5), // 그림자 색상과 투명도
                    borderRadius: BorderRadius.circular(10), // 모서리 둥글게
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Colors.black26,
                          width: 0.5,
                        ),
                      ),
                      leading: Text(
                        article.mood,
                        style: TextStyle(fontSize: Sizes.size36),
                      ),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formattedDate),
                          Text(
                            article.description,
                            style: TextStyle(fontSize: Sizes.size24),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("삭제"),
                                content: const Text("이 글을 삭제하시겠습니까?"),
                                actions: [
                                  TextButton(
                                    child: const Text("취소"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text("삭제"),
                                    onPressed: () async {
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
                    ),
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
