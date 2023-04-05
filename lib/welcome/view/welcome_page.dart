import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/audit/view/ballot_audit_page.dart';
import 'package:mobile_voting_verifier/shared/current_page_indicator.dart';
import 'package:mobile_voting_verifier/welcome/widgets/welcome_page_header.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  bool first = true;
  final List<TextButton> items = [];

  @override
  Widget build(BuildContext context) {
    if (first) {
      Future.delayed(const Duration(milliseconds: 50),
          () => setState(() => first = false));
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CurrentPageIndicator(
            currentStep: 3,
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: first ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const WelcomePageHeader(),
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(151, 36, 46, 1.0),
                                    Color.fromRGBO(126, 40, 83, 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const BallotAuditScreen())),
                            },
                            child: const Text('Audit ballot'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .popUntil((route) => !Navigator.canPop(context)),
        backgroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
