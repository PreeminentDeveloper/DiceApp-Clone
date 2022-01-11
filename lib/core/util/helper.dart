// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';


final Logger logger = Logger();

class Helpers {
  static final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: '');

  /// get devices height
  static double getDeviceHeight(BuildContext? context) {
    return MediaQuery.of(context!).size.height;
  }

  /// get devices height
  static double getDeviceWidth(BuildContext? context) {
    return MediaQuery.of(context!).size.width;
  }

  static String moneyFormat(final price) {
    try {
      return '${formatCurrency.format(num.tryParse(price))}';
    } catch (e) {
      return '${formatCurrency.format(num.tryParse('0'))}';
    }
  }

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
}
