import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String localToIsoString(DateTime dateTime) => DateFormat('d MMMM, yyyy ').format(dateTime.toLocal());

  static String formatDate(DateTime dateTime) => DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);

  static String estimatedDate(DateTime dateTime) => DateFormat('dd MMM yyyy').format(dateTime);

  static DateTime convertStringToDatetime(String dateTime) => DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateTime);
  static String dateStringMonthYear(DateTime ? dateTime) => DateFormat('d MMM,y').format(dateTime!);

  static DateTime isoStringToLocalDate(String dateTime) => DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime,true).toLocal();

  static String localDateToIsoStringAMPM(DateTime dateTime) => DateFormat('dd/MM/yyyy').format(dateTime.toLocal());

  static String supportTicketDateFormat(DateTime dateTime) => DateFormat('h:mm a dd MMM,yyyy').format(dateTime.toLocal());

  static String localDateToIsoStringAMPMOrder(DateTime dateTime) => DateFormat('dd MMM yyyy, h:mm a ').format(dateTime.toLocal());

  static String isoStringToLocalTimeOnly(String dateTime) => DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));

  static String getLocalTimeWithAMPM(String dateTime) => DateFormat('hh:mm a ').format(isoStringToLocalDate(dateTime));

  static String isoStringToLocalDateOnly(String dateTime) => DateFormat('dd:MM:yy').format(isoStringToLocalDate(dateTime));

  static String localDateToIsoString(DateTime dateTime) => DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime.toLocal());

  static String isoStringToLocalDateAndTime(String dateTime) => DateFormat('dd-MMM-yyyy hh:mm a').format(isoStringToLocalDate(dateTime));

  static String isoStringToLocalDateAndTimeConversation(String dateTime) => DateFormat('dd MMM yyyy \'at\' ${_timeFormatter()}').format(isoUtcStringToLocalDate(dateTime));

  static DateTime isoUtcStringToLocalDate(String dateTime) => DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();

  static String dateFormatForWalletBonus(String dateTime) => DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
  static String dateTimeStringToDateTime(String dateTime) => DateFormat('dd MMM, yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));

  static String dateTimeStringToDateAndTime(String dateTime) => DateFormat('hh:mm a, dd MMM yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));

  static String dateTimeStringToMonthDateAndTime(String dateTime) => DateFormat('MMMM d, yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));

  static String refundDateTime(String dateTime) => DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));

  static String estimatedDateYear(DateTime dateTime) => DateFormat('dd-MM-yyyy').format(dateTime);
  static String inboxLocalDateToIsoStringAMPM(DateTime dateTime) => DateFormat('${_timeFormatter()} | dd-MMM-yyyy ').format(dateTime.toLocal());

  static DateTime isoUtcStringToLocalTimeOnly(String dateTime) => DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();

  static String convertStringTimeToDate(DateTime time) => DateFormat('EEE \'at\' ${_timeFormatter()}').format(time.toLocal());

  static String convertStringTimeToDateChatting(DateTime time) => DateFormat('EEE \'at\' ${_timeFormatter()}').format(time.toLocal());

  static String convert24HourTimeTo12HourTimeWithDay(DateTime time, bool isToday) {
    if(isToday){
      return DateFormat('\'Today at\' ${_timeFormatter()}').format(time);
    }else{
      return DateFormat('\'Yesterday at\' ${_timeFormatter()}').format(time);
    }

  }

  static String convert24HourTimeTo12HourTime(DateTime time) => DateFormat(_timeFormatter()).format(time);

  static String _timeFormatter() => 'hh:mm a';

  static String customTime(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime justNow = now.subtract(const Duration(minutes: 1));
    final DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'just now';
    }

    final String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return roughTimeString;
    }

    final DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return 'yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {

      final String weekday = DateFormat('EEEE').format(dateTime.toLocal());

      return weekday;
    }

    return localDateToIsoStringAMPM(dateTime);
  }

  static String compareDates(String inputDate) {
    final DateTime currentDate = DateTime.now();
    final DateTime parsedDate = DateTime.parse(inputDate);

    final Duration difference = currentDate.difference(parsedDate);
    final int hoursDifference = difference.inHours;
    final int daysDifference = difference.inDays;

    if (hoursDifference < 1) {
      return DateFormat('hh:mm a').format(parsedDate);
    } else if (hoursDifference >= 1 && hoursDifference <= 23) {
      return '$hoursDifference hr ago';
    } else if (daysDifference == 1) {
      return 'Yesterday';
    } else if (daysDifference >= 2 && daysDifference <= 7) {
      return '$daysDifference days ago';
    } else {
      return DateFormat('MM/dd/yyyy').format(parsedDate);
    }
  }

  static int countDays(DateTime ? dateTime) {
    final startDate = dateTime!;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference;
  }

  static String getRelativeDateStatus(String inputDate, BuildContext context) {
    try {
      final parsedDate = DateTime.parse(inputDate);
      final currentDate = DateTime.now();
      final normalizedParsedDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
      final normalizedCurrentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
      final difference = normalizedCurrentDate.difference(normalizedParsedDate).inDays;

      if (difference == 0) {
        return 'Today';
      } else if (difference == 1) {
        return 'Yesterday';
      } else {
        return DateFormat('MM/dd/yyyy').format(parsedDate);
      }
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String durationDateTime(DateTime dateTime) => DateFormat('MM/dd/yyyy hh:mm:ss a').format(dateTime);
  static DateTime? convertDurationDateTimeFromString(String? dateTime) => DateFormat('MM/dd/yyyy hh:mm:ss a').tryParse(dateTime ?? '');

}
