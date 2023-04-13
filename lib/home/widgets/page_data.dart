import 'package:flutter/material.dart';

final pages = [
  const PageData(
      icon: Icons.home_outlined,
      title: "Home",
      headerDescription: "Press button below to begin verifying your ballot",
      bgColor: Color.fromRGBO(244, 245, 247, 1),
      gradiantColor: Color.fromRGBO(126, 40, 83, 1),
      textColor: Color.fromRGBO(151, 36, 46, 1.0)),
  const PageData(
    icon: Icons.info_outline,
    bgColor: Color.fromRGBO(244, 245, 247, 1),
    gradiantColor: Color.fromRGBO(126, 40, 83, 1),
    textColor: Color.fromRGBO(151, 36, 46, 1.0),
    title: "Info",
    headerDescription: "How to verify your ballot?",
    descriptions: [
      ListTile(
        title: Text(
          "Begin the verification process.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            "Open the QR-Code scanner by pressing the button at the bottom of the screen."),
      ),
      ListTile(
        title: Text("Step 1",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Point your camera at the QR-Code displayed on the voting device.",
        ),
        trailing: Icon(Icons.qr_code_scanner_rounded),
      ),
      ListTile(
        title: Text("Step 2",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Enter the 6 digit one-time password displayed on the voting device."),
        trailing: Icon(Icons.password_rounded),
      ),
      ListTile(
        title: Text("Step 3", 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Press the 'Audit ballot' button to display your recorded vote."),
        trailing: Icon(Icons.ads_click_rounded),
      ),
      ListTile(
        title: Text("Step 4",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Verify that the vote displayed on the screen matches your choice."),
        trailing: Icon(Icons.ballot_outlined),
      ),
    ],
  ),
];

class PageData {
  final String title;
  final String headerDescription;
  final List<ListTile> descriptions;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Color gradiantColor;
  final String? url; //Webpage link for pages pointing to web location

  const PageData(
      {this.title = "Default Title",
      this.headerDescription = "Default Header Description",
      this.descriptions = const [],
      this.icon,
      this.bgColor = Colors.grey,
      this.textColor = Colors.black,
      this.gradiantColor = Colors.purple,
      this.url});
}

Widget buildPage(BuildContext context, int index, double actionButtonSize,
    PageController pageController) {
  final page = pages[index];
  return page.title == "Info"
      ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(page.title, style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 10),
            Text(page.headerDescription,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(133, 153, 170, 1))),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemExtent: 110,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: page.descriptions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, _index) => Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(child: page.descriptions[_index]),
                      )),
            ),
          ],
        )
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(page.title, style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 10),
              Text(
                page.headerDescription,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(133, 153, 170, 1),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              /* TextButton(
                onPressed: () => {pageController.jumpToPage(1)},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [page.textColor, page.gradiantColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text("See Walkthrough",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              ), */
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Icon(
                Icons.arrow_downward_rounded,
                size: MediaQuery.of(context).size.height * 0.1,
                color: page.textColor,
              ),
            ],
          ),
        );
}
