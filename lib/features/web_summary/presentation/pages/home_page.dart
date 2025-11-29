import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:web_summarist/features/web_summary/presentation/controllers/providers.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/alert_dialog_widget.dart';
import 'package:web_summarist/features/web_summary/domain/enums/url_validation_state.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/list_view_widget.dart';
import 'package:web_summarist/features/web_summary/presentation/widgets/url_input_field.dart';
import '../../data/models/urls_model.dart';
import '../../domain/enums/web_summary_state.dart';
import '../controllers/url_ui_state.dart';
import 'summary_result_page.dart';

class MyHomePage extends ConsumerWidget {
  final TextEditingController controller = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urls = ref.watch(urlsViewModelProvider);
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
          final summary = current.webSummaryUiState.summaryText ?? '';
          final url = current.webSummaryUiState.url ?? controller.text;

          ref
              .read(urlsViewModelProvider.notifier)
              .addUrl(
                UrlsModel(
                  url: url,
                  summaryresult: summary,
                  date: DateTime.now(),
                ),
              );

          ref
              .read(summaryResultViewModelProvider.notifier)
              .loadData(url: url, summary: summary);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SummaryResultPage()),
          ).then((_) {
            ref.read(homeViewModelProvider.notifier).resetSummaryState();
          });
        }

        if (summaryState == WebSummaryState.failed) {
          final err =
              current.webSummaryUiState.errorMessage ??
              current.errorMessage ??
              'Unknown error';
          showDialog(
            context: context,
            builder:
                (_) => AlertDialogWidget(
                  title: Text(l10n.failed),
                  message: Text(err),
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

    return SafeArea(
      child: Scaffold(
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
                  UrlInputField(
                    controller: controller,
                    hintText: l10n.enter_url,
                  ),
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
              urls.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.recently_txt,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.push('/see-all'),
                              child: Text(l10n.see_all),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 105,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: urls.length,
                          itemBuilder: (context, index) {
                            final item = urls[index];
                            final uri = Uri.parse(item.url);
                            final String uu = uri.host.replaceFirst('www.', '');
                            final String domainWithoutSuffix =
                                uu.split('.').first;
                            return ListViewWidget(
                              title: domainWithoutSuffix,
                              ontap: () {
                                controller.text = item.url;
                              },
                              date: item.date,
                              result: item.summaryresult,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
