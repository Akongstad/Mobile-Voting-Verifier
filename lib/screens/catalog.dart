import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/screens/home.dart';
import 'package:mobile_voting_verifier/screens/qr_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

final pages = [
  const PageData(
      icon: Icons.qr_code_scanner_rounded,
      title: "Scan Ballot QR-Code",
      bgColor: Colors.indigo,
      textColor: Colors.white,
      gradiantColor: Color(0xff1eb090),
      destinationPage: QrScannerPage()),
  const PageData(
      icon: Icons.info_outline,
      title: "Information Page",
      bgColor: Color(0xff1eb090),
      textColor: Colors.white,
      gradiantColor: Color(0xfffeae4f),
      destinationPage: HomePage(title: 'title')),
  const PageData(
      icon: Icons.code,
      title: "Visit Official Github Page",
      bgColor: Color(0xfffeae4f),
      textColor: Colors.white,
      gradiantColor: Colors.indigo,
      destinationPage: HomePage(title: 'title'),
      url: 'https://github.com/Akongstad/Mobile-Voting-Verifier'),
];

class PageData {
  final String title;
  final String description;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color gradiantColor;
  final Widget destinationPage;
  final String? url; //Webpage link for pages pointing to web location

  const PageData(
      {this.title = "Default Title",
      this.description = "Default Description",
      this.icon,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.gradiantColor = Colors.blue,
      required this.destinationPage,
      this.url});
}

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  // Store the currently visible page
  int _currentPage = 0;
  double _actionButtonSize = 80;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(right: _actionButtonSize/2),
                  child: TextButton(
                      onPressed: () => {},
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.home_outlined, color: Colors.grey,),
                          Text("Home", style: TextStyle(color: Colors.grey, fontSize: 10),)
                        ],
                      ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: _actionButtonSize/2),
                  child: TextButton(
                    onPressed: () => {},
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outlined, color: Colors.grey,),
                        Text("More", style: TextStyle(color: Colors.grey, fontSize: 10),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),),
      floatingActionButton: SizedBox(
        height: _actionButtonSize,
        width: _actionButtonSize,
        child: FloatingActionButton(
          onPressed: () => {},
          backgroundColor: Colors.white,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_scanner_rounded, color: Colors.redAccent, size: 35,),
              //Text("Scan", style: TextStyle(color: Colors.grey, fontSize: 10),)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.8, 1),
              colors: [
                pages[_currentPage].bgColor,
                pages[_currentPage].gradiantColor,
              ]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (idx) async => setState(() {
                    _currentPage = idx;
                  }),
                  itemBuilder: (context, idx) {
                    final item = pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  if (item.url != null) {
                                    var uri = Uri.parse(item.url!);
                                    var urlLaunchable = await canLaunchUrl(
                                        uri); //canLaunch is from url_launcher package
                                    if (urlLaunchable) {
                                      await launchUrl(
                                          uri); //launch is from url_launcher package to launch URL
                                    } else {
                                      print("URL can't be launched.");
                                    }
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                item.destinationPage));
                                  }
                                },
                                child: Icon(
                                  item.icon,
                                  size: MediaQuery.of(context).size.width / 2,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        )),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.textColor,
                                        )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: pages[_currentPage] == item ? 36 : 10,
                          height: 10,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
