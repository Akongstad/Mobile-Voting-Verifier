import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile_voting_verifier/screens/qr_scanner.dart';
import 'package:mobile_voting_verifier/widgets/catalog/page_data.dart';
import 'package:mobile_voting_verifier/widgets/current_page_indicator.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  // Define the size of the action button
  final double _actionButtonSize = 90;

  // Store the currently visible page
  int _currentPage = 0;
  //Define pageindicator

  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).appBarTheme.foregroundColor;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: _actionButtonSize / 2),
                  child: TextButton(
                    onPressed: () => _pageController.jumpToPage(0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: _currentPage == 0 ? themeColor : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color:
                                  _currentPage == 0 ? themeColor : Colors.grey,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: _actionButtonSize / 2),
                  child: TextButton(
                    onPressed: () => _pageController.jumpToPage(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outlined,
                            color:
                                _currentPage == 1 ? themeColor : Colors.grey),
                        Text(
                          "Info",
                          style: TextStyle(
                              color:
                                  _currentPage == 1 ? themeColor : Colors.grey,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: _actionButtonSize,
        width: _actionButtonSize,
        child: FloatingActionButton(
          splashColor: themeColor!.withOpacity(0.5),
          onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const QrScannerPage())),
          },
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner_rounded,
                color: themeColor,
                size: 35,
              ),
              //Text("Scan", style: TextStyle(color: Colors.grey, fontSize: 10),)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //extendBody: true,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          onPageChanged: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return buildPage(context, index, _actionButtonSize, _pageController);
          },
        ),
      ),
    );
  }
}
