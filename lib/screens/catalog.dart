import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/screens/home.dart';
import 'package:mobile_voting_verifier/screens/qr_scanner.dart';

final pages = [
  const PageData(
      icon: Icons.qr_code_2_outlined,
      title: "Scan Ballot QR-Code",
      bgColor: Color(0xff3b1790),
      textColor: Colors.white,
      destinationPage: QrScannerPage()),
  const PageData(
      icon: Icons.info_outline,
      title: "Information Page",
      bgColor: Color(0xffff9200),
      textColor: Color(0xff3b1790),
      destinationPage: HomePage(title: 'title')),
  const PageData(
      icon: Icons.web_outlined,
      title: "Visit Official Election Page",
      bgColor: Colors.white,
      textColor: Color(0xffff9200),
      destinationPage: HomePage(title: 'title')),
];

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color gradiantColor;
  final Widget destinationPage;

  const PageData(
      {this.title,
      this.icon,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.gradiantColor = Colors.blue,
      required this.destinationPage});
}

class Catalog extends StatelessWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3), // visual center
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        // enable itemcount to disable infinite scroll
        // itemCount: pages.length,
        // opacityFactor: 2.0,
        scaleFactor: 2,
        // verticalPosition: 0.7,
        // direction: Axis.vertical,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: page.textColor),
          child: InkWell(
            onTap: () {Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => page.destinationPage),
              );
            },
            child: Icon(
              page.icon,
              size: screenHeight * 0.1,
              color: page.bgColor,
            ),
          ),
        ),
        Text(
          page.title ?? "",
          style: TextStyle(
              color: page.textColor,
              fontSize: screenHeight * 0.035,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
