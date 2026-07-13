import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../env/environment.dart';

final environmentProvider = Provider<Environment>((ref) {
  return Environment.development;
});
