import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewWidget extends StatelessWidget {
  final String title;
  final String result;
  final DateTime date;
  final GestureTapCallback ontap;

  const ListViewWidget({
    super.key,
    required this.title,
    required this.result,
    required this.date,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formattedDate = DateFormat('MMMd  HH:mm').format(date);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          color: colors.secondary.withAlpha(150),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.black.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
              offset: const Offset(4, 4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1.5, 1.5),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
                onTap: ontap,
                contentPadding: EdgeInsets.zero,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      result,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.onSurfaceVariant,
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
