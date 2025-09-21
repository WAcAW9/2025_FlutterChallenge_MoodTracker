import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/articles/models/article_model.dart';
import 'package:mood_tracker/features/articles/repos/articles_repo.dart';

final articlesRepoProvider = Provider((ref) => ArticlesRepo());

class ArticleViewModel extends AsyncNotifier<List<Article>> {
  @override
  Future<List<Article>> build() async {
    final articlesRepo = ref.read(articlesRepoProvider);
    return articlesRepo.getAllArticles();
  }

  // 글 삭제
  Future<void> deleteArticle(String docId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final articlesRepo = ref.read(articlesRepoProvider);
      await articlesRepo.deleteArticle(docId);
      return articlesRepo.getAllArticles();
    });
  }
}

final articlesProvider = AsyncNotifierProvider<ArticleViewModel, List<Article>>(
  () => ArticleViewModel(),
);
