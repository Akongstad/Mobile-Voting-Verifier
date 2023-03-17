import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_voting_verifier/models/qr_code.dart';
import 'package:mobile_voting_verifier/screens/ballot_audit_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:mobile_voting_verifier/utilities/api_calls.dart';

//Inspiration: https://github.com/Tkko/Flutter_Pinput/blob/master/example/lib/demo/pinput_templates/rounded_with_shadow.dart
//Screen with TOTP validation form.
class PinputWidget extends StatefulWidget {
  const PinputWidget({Key? key, required this.qrCode}) : super(key: key);
  final QRCode qrCode;

  @override
  State<PinputWidget> createState() => _PinputWidgetState();
}

class _PinputWidgetState extends State<PinputWidget> {
  late TextEditingController controller;
  late FocusNode _node;

  //Dispose after controller and focusNode after use
  @override
  void dispose() {
    controller.dispose();
    _node.dispose();
    super.dispose();
  }

  //Init focusNode and controller
  //Focus nodes request focus to the pinput widget
  //Text controller used to interact with the input
  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Pin');
    controller = TextEditingController();
  }

  String? _validate(String? pin) {
    try {
      if (pin == "196308") {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BallotAuditScreen()));
        /*  TODO:
        String challengeCommitment =
            "challenge"; //calculateChallengeCommitment(); 
        var loginResponse = loginRequest(
            widget.qrCode.vid, widget.qrCode.nonce, pin!, challengeCommitment); */
        return null;
      } else {
        return "Invalid login";
      }
    } catch (e) {
      debugPrint(e.toString());
      return "Invalid login";
    } finally {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: const Color.fromRGBO(70, 69, 66, 1),
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(24),
      ),
    );

    //Cursor below input boxes
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Pinput(
      length: 6,
      validator: (pin) => _validate(pin),
      autofocus: false,
      onTap: () => _node.requestFocus(),
      onTapOutside: (e) => FocusScope.of(context).unfocus(),
      controller: controller,
      focusNode: _node,
      defaultPinTheme: defaultPinTheme,
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: Colors.black),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
      separator: const SizedBox(width: 16),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
              offset: Offset(0, 3),
              blurRadius: 16,
            )
          ],
        ),
      ),
      showCursor: true,
      cursor: cursor,
    );
  }
}
