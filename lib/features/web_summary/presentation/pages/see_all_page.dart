import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/providers.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/snackbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeeAllPage extends ConsumerWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final urls =
        ref.watch(urlListProvider).where((u) => u.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.recently_txt),
        centerTitle: true,
      ),
      body:
          urls.isEmpty
              ? Center(child: Text(l10n.noSavedUrlsYet))
              : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: urls.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final url = urls[index];
                  return ListTile(
                    title: Text(
                      url,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.copy_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Copied: $url')),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outlined),
                          onPressed: () async {
                            await ref
                                .read(urlListProvider.notifier)
                                .removeUrl(url);
                            SnackbarWidget.show(
                              context,
                              title: l10n.delete,
                              message: l10n.dlt_msg,
                              icon: Icons.delete,
                              actionLabel: l10n.undo,
                              duration: Duration(seconds: 2),
                              onAction: () {
                                ref
                                    .read(urlListProvider.notifier)
                                    .undoRemoveUrl();
                                ScaffoldMessenger.of(
                                  context,
                                ).hideCurrentSnackBar();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
