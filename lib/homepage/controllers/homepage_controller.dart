import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simpleflutter/models/summary_model.dart';
import 'package:simpleflutter/services/http_service.dart';

// ignore: must_be_immutable
class HomePageController extends StatelessWidget {
  HomePageController({Key? key}) : super(key: key);

  String quoteToShow = "";
  int loadTotal = 3;
  int loadOthers = 5;

  final List<String> quotes = [
    "Wear a mask",
    "Clean your hands",
    "Keep a safe distance",
    "Get a vaccine when it's available to you."
  ];

  void startQuotes() {
    quoteToShow = quotes[Random().nextInt(quotes.length)];
  }

  Future<SummaryModel?> getCovidSummary() async {
    return await HttpService().getCovidSummary();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
