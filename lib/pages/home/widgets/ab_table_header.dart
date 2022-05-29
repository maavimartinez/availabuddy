import 'package:availabuddy/core/essentials/textstyles.dart';
import 'package:flutter/material.dart';

class AbTableHeaderRow extends TableRow {
  AbTableHeaderRow(BuildContext context, {required List<String> labels})
      : super(children: [
          for (final String label in labels)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                    child: Text(label, style: AbTextStyles.black16w700))),
        ]);
}
