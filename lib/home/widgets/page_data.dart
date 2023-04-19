import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final pages = [
    PageData(
        icon: Icons.home_outlined,
        title: AppLocalizations.of(context)!.home,
        headerDescription: AppLocalizations.of(context)!.homeHeaderDescription,
        bgColor: Color.fromRGBO(244, 245, 247, 1),
        gradiantColor: Color.fromRGBO(126, 40, 83, 1),
        textColor: Color.fromRGBO(151, 36, 46, 1.0)),
    PageData(
      icon: Icons.info_outline,
      bgColor: Color.fromRGBO(244, 245, 247, 1),
      gradiantColor: Color.fromRGBO(126, 40, 83, 1),
      textColor: Color.fromRGBO(151, 36, 46, 1.0),
      title: AppLocalizations.of(context)!.info,
      headerDescription: AppLocalizations.of(context)!.infoHeaderDescription,
      descriptions: [
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.infoStepZeroTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(AppLocalizations.of(context)!.infoStepZeroDescription),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.infoStepOneTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(
            AppLocalizations.of(context)!.infoStepOneDescription,
          ),
          trailing: Icon(Icons.qr_code_scanner_rounded),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.infoStepTwoTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(AppLocalizations.of(context)!.infoStepTwoDescription),
          trailing: Icon(Icons.password_rounded),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.infoStepThreeTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle:
              Text(AppLocalizations.of(context)!.infoStepThreeDescription),
          trailing: Icon(Icons.ads_click_rounded),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.infoStepFourTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(AppLocalizations.of(context)!.infoStepFourDescription),
          trailing: Icon(Icons.ballot_outlined),
        ),
      ],
    ),
  ];

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
