import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
routes: [
GoRoute(
path: '/',
builder: (context, state) {
return const Scaffold(
body: Center(
child: Text('DscienTia'),
),
);
},
),
],
);
