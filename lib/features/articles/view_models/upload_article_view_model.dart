import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/articles/models/article_model.dart';
import 'package:mood_tracker/features/articles/repos/articles_repo.dart';

class UploadArticleViewModel extends AsyncNotifier<void> {
  late final ArticlesRepo _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(articleRepo);
  }

  Future<void> uploadArticle(Article article, BuildContext context) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.saveArticle(article);
    });
    context.pushReplacement('/home');
  }
}

final UploadArticleProvider =
    AsyncNotifierProvider<UploadArticleViewModel, void>(
      () => UploadArticleViewModel(),
    );
