import 'package:flutter/material.dart';
import 'package:helper_core/core/util/custom_dialog/custom_dialog.dart';
import 'package:helper_core/core/util/custom_dialog/custom_dialog_data.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required CustomDialogData data,
  bool isDismissible = false,
}) async {
  return showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) => CustomDialog(
      data: data,
      isDismissible: isDismissible,
    ),
  );
}
