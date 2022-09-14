import 'dart:async';

import '../../model/status_model.dart';
import '../../utility/status_api.dart';

class StatusProvider {
  Stream<List<StatusModel>> loadStream() async* {
    while (true) {
      try {
        // gak error
        await Future<void>.delayed(const Duration(seconds: 1));
        final stat = await StatusApi.getStatus();
        yield stat;
      } catch (e) {}
    }
  }
}
