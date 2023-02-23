import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_voting_verifier/models/second_device_login.dart';
import 'package:mobile_voting_verifier/repositories/post_login_request.dart';
import 'package:mobile_voting_verifier/utilities/api_calls.dart';
import 'package:pinput/pinput.dart';
//Inspiration: https://github.com/Tkko/Flutter_Pinput/blob/master/example/lib/demo/pinput_templates/rounded_with_shadow.dart
//Screen with TOTP validation form.
class TOTPScreen extends StatefulWidget {
  const TOTPScreen({Key? key, required this.scanParams}) : super(key: key);
  final Map<String, String> scanParams;

  @override
  State<TOTPScreen> createState() => _TOTPScreenState();
}

class _TOTPScreenState extends State<TOTPScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  //Dispose after controller and focusNode after use
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
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
        color: const Color.fromRGBO(232, 235, 241, 0.37),
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
      validator: (pin) {
        //vid, nonce, pw
        var loginResponse = login(widget.scanParams['vid']!, widget.scanParams['nonce']!, pin!);
        return throw UnimplementedError();
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      separator: const SizedBox(width: 16),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.white,
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
      // onClipboardFound: (value) {
      //   debugPrint('onClipboardFound: $value');
      //   controller.setText(value);
      // },
      showCursor: true,
      cursor: cursor,
    );
  }
}
