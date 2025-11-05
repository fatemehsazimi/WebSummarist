import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  final String title;
  final GestureTapCallback ontap;

  const ListViewWidget({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: colors.secondary.withAlpha(150),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.black.withOpacity(0.4)
                      : Colors.grey.withOpacity(0.2),
              offset: const Offset(2, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
          onTap: ontap,
        ),
      ),
    );
  }
}
