import 'dart:async';

import '../../model/status_model.dart';
import '../../utility/status_api.dart';

class StatusProvider {
  Stream<List<StatusModel>> loadStream() async* {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 3));
      final stat = await StatusApi.getStatus();
      yield stat;
    }
  }
}
