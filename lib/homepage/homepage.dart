import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:simpleflutter/homepage/controllers/homepage_controller.dart';
import 'package:simpleflutter/models/summary_model.dart';
import 'package:simpleflutter/widgets/frosted.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController homepageController = HomePageController();
  late Future<SummaryModel?> covidSummary;

  @override
  void initState() {
    covidSummary = homepageController.getCovidSummary();
    homepageController.startQuotes();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        homepageController.quoteToShow = homepageController
            .quotes[Random().nextInt(homepageController.quotes.length)];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          covidSummary = homepageController.getCovidSummary();
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                child: FutureBuilder(
                  future: covidSummary,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null ||
                        snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      SummaryModel summary = snapshot.data;
                      return Stack(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 22.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Total Covid Cases",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  Countup(
                                    begin: 0,
                                    end: double.parse(
                                        summary.data.total.toString()),
                                    duration: Duration(
                                        seconds: homepageController.loadTotal),
                                    separator: ',',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 70,
                                    ),
                                  ),
                                  DefaultTextStyle(
                                    style: const TextStyle(
                                        color: Colors.white38, fontSize: 13),
                                    child: AnimatedTextKit(
                                      pause: const Duration(seconds: 3),
                                      repeatForever: true,
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          homepageController.quotes[0],
                                          speed:
                                              const Duration(milliseconds: 90),
                                        ),
                                        TyperAnimatedText(
                                            homepageController.quotes[1],
                                            speed: const Duration(
                                                milliseconds: 90)),
                                        TyperAnimatedText(
                                            homepageController.quotes[2],
                                            speed: const Duration(
                                                milliseconds: 90)),
                                        TyperAnimatedText(
                                            homepageController.quotes[3],
                                            speed: const Duration(
                                                milliseconds: 90)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 50),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FrostedGlass(
                                      height: 150,
                                      width: 150,
                                      innerWidget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('Recoveries',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12)),
                                          CircularPercentIndicator(
                                            radius: 40.0,
                                            lineWidth: 7.0,
                                            animation: true,
                                            percent: double.parse(summary
                                                    .data.recoveries
                                                    .toString()) /
                                                double.parse(summary.data.total
                                                    .toString()),
                                            center: Countup(
                                              begin: 0,
                                              end: double.parse(summary
                                                  .data.recoveries
                                                  .toString()),
                                              duration: Duration(
                                                  seconds: homepageController
                                                      .loadOthers),
                                              separator: ',',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ),
                                    FrostedGlass(
                                      height: 150,
                                      width: 150,
                                      innerWidget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('Deaths',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12)),
                                          CircularPercentIndicator(
                                            radius: 40.0,
                                            lineWidth: 7.0,
                                            animation: true,
                                            percent: double.parse(summary
                                                    .data.deaths
                                                    .toString()) /
                                                double.parse(summary.data.total
                                                    .toString()),
                                            center: Countup(
                                              begin: 0,
                                              end: double.parse(summary
                                                  .data.deaths
                                                  .toString()),
                                              duration: Duration(
                                                  seconds: homepageController
                                                      .loadOthers),
                                              separator: ',',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.blueGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FrostedGlass(
                                      height: 150,
                                      width: 150,
                                      innerWidget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('Active Cases',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12)),
                                          CircularPercentIndicator(
                                            radius: 40.0,
                                            lineWidth: 7.0,
                                            animation: true,
                                            percent: double.parse(summary
                                                    .data.activeCases
                                                    .toString()) /
                                                double.parse(summary.data.total
                                                    .toString()),
                                            center: Countup(
                                              begin: 0,
                                              end: double.parse(summary
                                                  .data.activeCases
                                                  .toString()),
                                              duration: Duration(
                                                  seconds: homepageController
                                                      .loadOthers),
                                              separator: ',',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                    FrostedGlass(
                                      height: 150,
                                      width: 150,
                                      innerWidget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text('Recovery Rate',
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12)),
                                          CircularPercentIndicator(
                                            radius: 40.0,
                                            lineWidth: 7.0,
                                            animation: true,
                                            percent: double.parse(summary
                                                    .data.recoveryRate
                                                    .toString()) /
                                                100,
                                            center: Countup(
                                              begin: 0.0,
                                              end: double.parse(summary
                                                  .data.recoveryRate
                                                  .toString()),
                                              duration: Duration(
                                                  seconds: homepageController
                                                      .loadOthers),
                                              separator: ',',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              suffix: '%',
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.greenAccent,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Pull to refresh",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.2),
                                      fontSize: 10),
                                ),
                                Text(
                                  "Last updated at: ${summary.lastUpdate}",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.2),
                                      fontSize: 10),
                                ),
                                Text(
                                  "-nmbmejia-",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.2),
                                      fontSize: 6),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
