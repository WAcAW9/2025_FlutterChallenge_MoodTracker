import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/tabNavigation/models/mood_model.dart';

class MoodViewModel extends AsyncNotifier<List<MoodmModel>> {
  // API로부터 받아올 데이터
  List<MoodmModel> _list = [MoodmModel(title: "1"), MoodmModel(title: "1")];

  void uploadMood() async {
    state = AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newMood = MoodmModel(title: "${DateTime.now()}");
    _list = [..._list, newMood];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<MoodmModel>> build() async {
    await Future.delayed(Duration(seconds: 5));
    return _list;
  }
}

final moodProvider = AsyncNotifierProvider<MoodViewModel, List<MoodmModel>>(
  () => MoodViewModel(),
);
