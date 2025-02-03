// FamilyProvider allows passing parameters when creating a provider,
//  making it useful for filtering data or fetching details dynamically.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyProvider = FutureProvider.family((red, arg) {
  return fetchUserData();
});

Future<String> fetchUserData() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'User Data';
}

class FamilyProvider extends ConsumerWidget {
  const FamilyProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(familyProvider('userId'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Provider'),
      ),
      body: Center(
        child: userAsyncValue.when(
          data: (data) => Text(data),
          error: ((e, stack) => Text(e.toString())),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
