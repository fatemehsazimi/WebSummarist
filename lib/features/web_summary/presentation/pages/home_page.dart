import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/providers.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/alert_dialog_widget.dart';
import 'package:web_summarist/features/web_summary/domain/enums/url_validation_state.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/list_view_widget.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/url_input_field.dart';
import '../../domain/enums/web_summary_state.dart';
import '../controllers/url_ui_state.dart';

class MyHomePage extends ConsumerWidget {
  final TextEditingController controller = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urls = ref.watch(urlListProvider);
    final nonEmptyUrls = urls.where((u) => u.trim().isNotEmpty).toList();
    final l10n = AppLocalizations.of(context)!;

    ref.listen<UrlUiState>(homeViewModelProvider, (previous, current) {
      final summaryState = current.webSummaryUiState.status;

      if (summaryState == WebSummaryState.loading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      } else {
        if (previous?.webSummaryUiState.status == WebSummaryState.loading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (summaryState == WebSummaryState.success) {
          ref.read(urlListProvider.notifier).addUrl(controller.text);
          showDialog(
            context: context,
            builder:
                (_) => AlertDialogWidget(
                  title: Text(l10n.successTitle),
                  message: Text(current.webSummaryUiState.summaryText ?? ""),
                  buttontxt: Text(l10n.ok_txt),
                ),
          ).then((_) {
            ref.read(homeViewModelProvider.notifier).resetSummaryState();
          });
        }

        if (summaryState == WebSummaryState.failed) {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialogWidget(
                  title: Text(l10n.failed),
                  message: Text(
                    current.webSummaryUiState.errorMessage ?? "Error",
                  ),
                  buttontxt: Text(l10n.ok_txt),
                ),
          ).then((_) {
            ref.read(homeViewModelProvider.notifier).resetSummaryState();
          });
        }
      }

      if (current.showDialog) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialogWidget(
                title: Text(
                  current.validationState == UrlValidationState.valid
                      ? l10n.valid
                      : l10n.error_txt,
                ),
                message: Text(
                  current.validationState == UrlValidationState.valid
                      ? l10n.validurl
                      : (current.errorMessage == 'error_empty_url'
                          ? l10n.error_empty_url
                          : l10n.error_invalid_url),
                ),
                buttontxt: Text(l10n.ok_txt),
              ),
        ).then((_) {
          ref.read(homeViewModelProvider.notifier).resetSummaryState();
        });
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                UrlInputField(controller: controller, hintText: l10n.enter_url),
                const SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    ref
                        .read(homeViewModelProvider.notifier)
                        .setUrl(controller.text);
                  },
                  child: Text(
                    l10n.submit,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            nonEmptyUrls.isNotEmpty
                ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.recently_txt,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () => context.push('/see-all'),
                            child: Text(l10n.see_all),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 65,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nonEmptyUrls.length,
                        itemBuilder: (context, index) {
                          return ListViewWidget(
                            title: nonEmptyUrls[index],
                            ontap: () {
                              controller.text = nonEmptyUrls[index];
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
