import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';

class SummaryResultPage extends ConsumerWidget {
  const SummaryResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(summaryResultViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Summary Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('URL:', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(state.url),
              const SizedBox(height: 16),

              const Text('Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(state.summary),
            ],
          ),
        ),
      ),
    );
  }
}
