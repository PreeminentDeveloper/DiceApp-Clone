import 'package:dice_app/core/navigation/page_router.dart';
import 'package:dice_app/core/util/pallets.dart';
import 'package:dice_app/core/util/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateOptions { withTime, past, future, general }

pickDate({
  required BuildContext context,
  required ValueChanged<String> onChange,
  bool showTime = false,
  DateOptions dateOptions = DateOptions.general,
}) async {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return _buildMaterialDatePicker(
          context: context,
          date: onChange,
          showTime: showTime,
          dateOptions: dateOptions);
    case TargetPlatform.macOS:
    case TargetPlatform.iOS:
      return _buildCupertinoDatePicker(
          context: context,
          date: onChange,
          showTime: showTime,
          dateOptions: dateOptions);
  }
}

/// This builds material date picker in Android
void _buildMaterialDatePicker({
  required BuildContext context,
  @required var date,
  bool showTime = false,
  DateOptions dateOptions = DateOptions.general,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(seconds: 1)),
    firstDate: _getFirstDate(dateOptions),
    lastDate: _getLastDate(dateOptions),
    builder: (context, child) {
      return child!;
    },
  );
  if (picked != null && picked != date) {
    if (showTime) {
      final _timer = await _selectTime(context);
      date('${DateFormat('yyyy-MM-dd').format(picked)} $_timer');
    } else {
      date(DateFormat('yyyy-MM-dd').format(picked));
    }
  }
}

_getFirstIOSDate(DateOptions dateOptions) {
  switch (dateOptions) {
    case DateOptions.general:
      return 1600;
    case DateOptions.past:
      return 1600;
    case DateOptions.future:
      return DateTime.now().year;
    default:
  }
}

_getLastIOSDate(DateOptions dateOptions) {
  switch (dateOptions) {
    case DateOptions.general:
      return 2025;
    case DateOptions.past:
      return DateTime.now().year;
    case DateOptions.future:
      return 2025;
    default:
  }
}

_getFirstDate(DateOptions dateOptions) {
  switch (dateOptions) {
    case DateOptions.general:
      return DateTime(1600);
    case DateOptions.past:
      return DateTime(1600);
    case DateOptions.future:
      return DateTime.now();
    default:
  }
}

_getLastDate(DateOptions dateOptions) {
  switch (dateOptions) {
    case DateOptions.general:
      return DateTime(2025);
    case DateOptions.past:
      return DateTime.now();
    case DateOptions.future:
      return DateTime(2025);
    default:
  }
}

_selectTime(BuildContext context) async {
  final TimeOfDay? _newTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (_newTime != null) return _newTime.format(context);
  return TimeOfDay.now().format(context);
}

/// This builds cupertino date picker in iOS
void _buildCupertinoDatePicker(
    {required BuildContext context,
      @required var date,
      bool showTime = false,
      DateOptions dateOptions = DateOptions.general}) {
  showSheet(
    context,
    child: SizedBox(
      height: SizeConfig.getDeviceHeight(context) * .2,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
            TextStyle(color: DColors.black, fontSize: 18),
          ),
        ),
        child: CupertinoDatePicker(
          mode: showTime
              ? CupertinoDatePickerMode.dateAndTime
              : CupertinoDatePickerMode.date,
          backgroundColor: Theme.of(context).cardColor,
          initialDateTime: DateTime.now(),
          minimumYear: _getFirstIOSDate(dateOptions),
          maximumYear: _getLastIOSDate(dateOptions),
          onDateTimeChanged: (picked) {
            if (picked != date) {
              if (showTime) {
                date(DateFormat('yyyy-MM-dd').format(picked));
              } else {
                date(DateFormat('yyyy-MM-dd').format(picked));
              }
            }
          },
        ),
      ),
    ),
  );
}

showSheet(BuildContext context, {required Widget child}) => showCupertinoModalPopup(
  context: context,
  builder: (context) => CupertinoActionSheet(
    actions: [child],
    cancelButton: CupertinoActionSheetAction(
      child:
      const Text('Done', style: TextStyle(color: DColors.accentColor)),
      onPressed: () {
        PageRouter.goBack(context);
      },
    ),
  ),
);
