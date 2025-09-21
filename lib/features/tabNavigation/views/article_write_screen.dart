import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/articles/models/article_model.dart';
import 'package:mood_tracker/features/articles/view_models/upload_article_view_model.dart';

class ArticleWriteScreen extends ConsumerStatefulWidget {
  const ArticleWriteScreen({super.key});

  @override
  ConsumerState<ArticleWriteScreen> createState() => _ArticleWriteScreenState();
}

class _ArticleWriteScreenState extends ConsumerState<ArticleWriteScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  late String _selectedMood = '';

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  // 이모지 탭 시 호출되는 함수
  void _onEmojiTap(String emoji) {
    setState(() {
      _selectedMood = emoji;
    });
  }

  void _onUploadPressed() {
    final article = Article(
      id: '',
      mood: _selectedMood,
      description: _descriptionController.text,
      date: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(UploadArticleProvider.notifier).uploadArticle(article, context);
  }

  String _getEmoji(int index) {
    const emojis = ['😀', '😍', '😊', '🤪', '😭', '🤬', '💬', '🤮'];
    return emojis[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "How do you feel?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Description TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: 'Write it down here!',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "What's your mood?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Emojis Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(8, (index) {
                    final emoji = _getEmoji(index);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _onEmojiTap(emoji), // 탭 이벤트 추가
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Material(
                            elevation: 4.0,
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _selectedMood == emoji
                                    ? Colors.amber.shade200
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                emoji,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),
                // Post button
                GestureDetector(
                  onTap: _onUploadPressed,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      elevation: 4.0,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Post',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
