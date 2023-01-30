// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DiscoverReleaseYear {
  DateTime? _specificYear;

  DateTime? get specificYear => _specificYear;

  set specificYear(DateTime? specificYear) {
    _specificYear = specificYear;
  }

  DateTimeRange? _range;

  DateTimeRange? get range => _range;

  set range(DateTimeRange? range) {
    _range = range;
  }
}
