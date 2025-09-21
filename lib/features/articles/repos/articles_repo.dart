import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/articles/models/article_model.dart';

class ArticlesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 글 작성
  Future<void> saveArticle(Article data) async {
    await _db.collection("articles").add(data.toJson());
  }

  // 글 모두 가져오기
  Future<List<Article>> getAllArticles() async {
    final snapshot = await _db.collection("articles").get();
    return snapshot.docs
        .map((doc) => Article.fromJson(doc.id, doc.data()))
        .toList();
  }

  // 글 삭제
  Future<void> deleteArticle(String docId) async {
    await _db.collection("articles").doc(docId).delete();
  }
}

final articleRepo = Provider((ref) => ArticlesRepo());
