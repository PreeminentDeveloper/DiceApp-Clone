import 'package:dice_app/core/util/helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class TimeUtil {
  static String formatDate(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatDate = DateFormat("MMM dd, yyyy").format(_dt);
    String _formatTime = DateFormat("HH:MM a").format(_dt);

    return '$_formatDate at $_formatTime';
  }

  static String formatDate2(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatDate = DateFormat("dd/MM/yyyy").format(_dt);
    String _formatTime = DateFormat("HH:MM").format(_dt);

    return '$_formatTime, $_formatDate';
  }

  static String chatTime(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatTime = DateFormat("hh:mm a").format(_dt);

    return _formatTime;
  }

  static String chatTime2(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatTime = DateFormat("dd-MM-yyyy hh:mm:ss").format(_dt);

    return _formatTime;
  }

  static String chatDate(String? date) {
    if (date!.isEmpty) return '';
    DateTime _dt = DateTime.parse(date);
    String _formatTime = DateFormat("dd-MM-yyyy").format(_dt);
    return _formatTime;
  }

  static String timeAgoSinceDate(String dateString) {
    List<String> _dateList = dateString.split('-');
    int _day = int.parse(_dateList[0]);
    int _year = int.parse(_dateList[2]);
    int _month = int.parse(_dateList[1]);

    final _temp = DateTime(_year, _month, _day);
    final _presentDate = DateTime.now();

    final _difference = _presentDate.difference(_temp);

    if (_difference.inDays > 1) {
      return '$_day ${_getMonth(_month)} $_year';
    }

    if (_difference.inDays == 0) {
      return 'Today';
    }

    if (_difference.inDays == 1) {
      return 'Yesterday';
    }

    return '';
  }

  static String _getMonth(int month) {
    switch (month) {
      case 01:
        return 'January';
      case 02:
        return 'February';
      case 03:
        return 'March';
      case 04:
        return 'April';
      case 05:
        return 'May';
      case 06:
        return 'June';
      case 07:
        return 'July';
      case 08:
        return 'August';
      case 09:
        return 'September';
      case 10:
        return 'october';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
    }
    return '';
  }
}
