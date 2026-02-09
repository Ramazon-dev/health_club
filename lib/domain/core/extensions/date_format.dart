import 'package:flutter/material.dart';
import 'package:health_club/domain/core/extensions/string_ext.dart';
import 'package:intl/intl.dart';

extension DateFormatExt on DateTime {
  String dateFormat() {
    return DateFormat('dd.MM.yyy').format(this);
  }

  String monthAndYear() {
    return DateFormat('MMMM yyyy').format(this);
  }

  bool isSameDay(DateTime date) {
    final first = DateTime(year, month, day);
    final second = DateTime(date.year, date.month, date.day);
    return first.isAtSameMomentAs(second);
  }

  bool isAfterOrSame(DateTime date) {
    final first = DateTime(year, month, day);
    final second = DateTime(date.year, date.month, date.day);
    return  first.isAfter(second) || first.isAtSameMomentAs(second);
  }

  String homeDateFormat() {
    return DateFormat('EE, dd MMM').format(this).toUppercaseFirstLetter();
  }

  String weekFormat() {
    return DateFormat('EEEE dd MMM', 'ru_RU').format(this).toUppercaseFirstLetter();
  }

  String dateMonth() {
    return DateFormat('MMMM').format(this).toUppercaseFirstLetter();
  }

  String dateForRequest() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String dayOfWeek() {
    return DateFormat('EEEE').format(this);
  }

  String shortDayOfWeek() {
    return DateFormat('EE', 'ru_RU').format(this);
  }

  String dayOfWeekUz() {
    return DateFormat('EEE', 'uz_UZ').format(this);
  }

  String dayOfWeekRu() {
    return DateFormat('EEE', 'ru_RU').format(this);
  }

  String dayOfWeekEn() {
    return DateFormat('EEE', 'en_US').format(this);
  }

  String fullDayOfWeekEn() {
    return DateFormat('EEEE', 'en_US').format(this).toLowerCase();
  }

  // String weekFormatLonger(Languages lang) {
  //   switch (lang) {
  //     case Languages.uz:
  //       return dayOfWeekUz().toUppercaseFirstLetter();
  //     case Languages.ru:
  //       return dayOfWeekRu().toUppercaseFirstLetter();
  //     case Languages.en:
  //       return dayOfWeekEn().toUppercaseFirstLetter();
  //   }
  // }

  // String weekFormat(Languages lang) {
  //   switch (lang) {
  //     case Languages.uz:
  //       return dayOfWeekUz().toUppercaseFirstLetter();
  //     case Languages.ru:
  //       return dayOfWeekRu().toUppercaseFirstLetter();
  //     case Languages.en:
  //       return dayOfWeekEn().toUppercaseFirstLetter();
  //   }
  // }

  String fullDate() {
    return DateFormat('EE, dd, MMMM. yyyy. HH-mm').format(this).capitalize();
  }

  String notificationDate() {
    return DateFormat('EE, dd MMMM').format(this).capitalize();
  }

  String bookingDate() {
    return DateFormat('dd MMMM HH:mm', 'ru_RU').format(this);
  }

  List<String> daysOfWeek() {
    return [
      DateFormat('E').format(DateTime(2025, 1, 6)),
      DateFormat('E').format(DateTime(2025, 1, 7)),
      DateFormat('E').format(DateTime(2025, 1, 8)),
      DateFormat('E').format(DateTime(2025, 1, 9)),
      DateFormat('E').format(DateTime(2025, 1, 10)),
      DateFormat('E').format(DateTime(2025, 1, 11)),
      DateFormat('E').format(DateTime(2025, 1, 12)),
    ];
  }

  String dateTimeFormatMinuteHour() {
    return DateFormat(DateFormat.HOUR_MINUTE).format(this);
  }
}

extension TimeOfDayExt on TimeOfDay {
  toHHmm() {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    final format = DateFormat.Hm();
    return format.format(dateTime);
  }
}

extension DateFromStringEx on String {
  String dateFormatHHMMFromString() {
    final formatter = DateFormat.Hm();
    return formatter.format(DateFormat('HH:mm:ss').parse(this));
  }

  DateTime minuteToDateTime() {
    final t = DateFormat('HH:mm').parseStrict(this);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  DateTime? tryParse() {
    try {
      final format = DateFormat('dd-MM-yyyy');
      return format.parse(this);
    } catch (e) {
      print('object tryParse error $e');
      return null;
    }
  }

  DateTime? parse() {
    try {
      final format = DateFormat('dd.MM.yyyy');
      return format.parse(this);
    } catch (e) {
      print('object tryParse error $e');
      return null;
    }
  }
  DateTime? parseFromDate() {
    try {
      final format = DateFormat('yyyy-MM-dd');
      return format.parse(this);
    } catch (e) {
      print('object tryParse error $e');
      return null;
    }
  }
}

enum DayOfWeek {
  monday('Понеделник'),
  tuesday('Вторник'),
  wednesday('Среда'),
  thursday('Четверг'),
  friday('Пятница'),
  saturday('Суббота'),
  sunday('Воскресения');

  final String name;
  const DayOfWeek(this.name);
}
