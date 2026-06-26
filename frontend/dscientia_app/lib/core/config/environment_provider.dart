import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'environment.dart';

final environmentProvider = Provider<Environment>((ref) {
return Environment.development;
});
