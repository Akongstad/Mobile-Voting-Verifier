import 'package:flutter/material.dart';

final pages = [
  const PageData(
    icon: Icons.home_outlined,
    title: "Scan Ballot QR-Code",
    headerDescription: "",
    bgColor: Color.fromRGBO(244, 245, 247, 1),
    gradiantColor: Color.fromRGBO(126, 40, 83, 1),
  ),
  const PageData(
    icon: Icons.info_outline,
    bgColor: Color.fromRGBO(244, 245, 247, 1),
    gradiantColor: Color.fromRGBO(126, 40, 83, 1),
    title: "Info",
    headerDescription: "How to verify your ballot?",
    descriptions: [
      ExpansionTile(
        title: Text(
          "Step 1",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            "Open the QR-Code scanner by pressing the button with the qr-code below"),
        trailing: Icon(Icons.more_vert_outlined),
      ),
      ExpansionTile(
        title: Text("Step 2", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text("Allow the app to access your camera",),
        trailing: Icon(Icons.more_vert_outlined),
      ),
      ExpansionTile(
        title: Text("Step 3", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Point your camera at the QR-Code on your ballot displayed on the main voting screen"),
        trailing: Icon(Icons.more_vert_outlined),
      ),
      ExpansionTile(
        title: Text("Step 4", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "If the QR-Code is valid, you will be redirected to the verification screen"),
        trailing: Icon(Icons.more_vert_outlined),
      ),
      ExpansionTile(
        title: Text("Step 5", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text("Input the pin code from your voting device"),
        trailing: Icon(Icons.more_vert_outlined),
      ),
      ExpansionTile(
        title: Text("Step 6", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "If the pin code is valid, your ballot will be displayed on the screen."),
        trailing: Icon(Icons.more_vert_outlined),
      ),
      ExpansionTile(
        title: Text("Step 7", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Verify the ballot has been cast as intended"),
        trailing: Icon(Icons.more_vert_outlined),
      ),
    ],
  ),
];

class PageData {
  final String title;
  final String headerDescription;
  final List<ExpansionTile> descriptions;
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

Widget buildPage(BuildContext context, int index, double actionButtonSize) {
  final page = pages[index];
  return SafeArea(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(page.title, style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 10),
        Text(page.headerDescription,
            style: const TextStyle(
                fontSize: 20  ,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(133, 153, 170, 1))),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              itemExtent: 100,
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
    ),
  );
}
