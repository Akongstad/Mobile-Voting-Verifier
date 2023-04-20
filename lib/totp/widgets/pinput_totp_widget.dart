import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_voting_verifier/qr_scanner/models/qr_code.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//Inspiration: https://github.com/Tkko/Flutter_Pinput/blob/master/example/lib/demo/pinput_templates/rounded_with_shadow.dart
//Screen with TOTP validation form.
class PinputWidget extends StatefulWidget {
  PinputWidget({Key? key, required this.qrCode, required this.pinValidated})
      : super(key: key);
  final QRCode qrCode;
  Function pinValidated;

  @override
  State<PinputWidget> createState() => _PinputWidgetState();
}

class _PinputWidgetState extends State<PinputWidget> {
  late TextEditingController controller;
  late FocusNode _node;
  final formKey = GlobalKey<FormState>();

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

  String? _validate(String? pin, BuildContext context) {
    try {
      sleep(Duration(milliseconds: 500));
      if (pin == "196308") {
        widget.pinValidated();
        // Simulate network request: POST rest/login that returns
        // SecondDeviceLoginResponse
        /*  TODO:

        String challengeCommitment =
            "challenge"; //calculateChallengeCommitment(); 
        var loginResponse = loginRequest(
            widget.qrCode.vid, widget.qrCode.nonce, pin!, challengeCommitment); */
        return null;
      } else {
        return AppLocalizations.of(context)!.totpHeaderInvalidLogin;
      }
    } catch (e) {
      debugPrint(e.toString());
      return AppLocalizations.of(context)!.totpHeaderInvalidLogin;
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

    return Form(
      key: formKey,
      child: Pinput(
        length: 6,
        validator: (pin) => _validate(pin, context),
        autofocus: false,
        onTapOutside: (e) => FocusScope.of(context).unfocus(),
        controller: controller,
        focusNode: _node,
        defaultPinTheme: defaultPinTheme,
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(19),
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
      ),
    );
  }
}
