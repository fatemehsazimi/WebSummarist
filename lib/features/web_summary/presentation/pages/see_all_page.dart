import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/url_list_viewmodel.dart';
import '../controllers/providers.dart';
import '../widgets/snackbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeeAllPage extends ConsumerWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urls = ref.watch(urlsViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.recently_txt)),
      body:
          urls.isEmpty
              ? Center(child: Text(l10n.noSavedUrlsYet))
              : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: urls.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final urlModel = urls[index];
                  return ListTile(
                    title: Text(urlModel.url),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.copy_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Copied: ${urlModel.url}'),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outlined),
                          onPressed: () async {
                            await ref
                                .read(urlsViewModelProvider.notifier)
                                .removeUrl(index);
                            SnackbarWidget.show(
                              context,
                              title: l10n.delete,
                              message: l10n.dlt_msg,
                              icon: Icons.delete,
                              actionLabel: l10n.undo,
                              onAction: () {
                                ref
                                    .read(urlsViewModelProvider.notifier)
                                    .undoRemoveUrl();
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
