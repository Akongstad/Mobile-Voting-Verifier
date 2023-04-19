import 'package:flutter/material.dart';

class BallotAuditCheckBox extends StatefulWidget {
  const BallotAuditCheckBox(
      {Key? key,
      required this.checkedMap,
      required this.id,
      this.title = "Beware! This will not change your vote",
      this.content = "This will only modify the visualisation on this device.\n\n"
          "Q: Why may I edit my ballot?\n"
          "A: To ensure a voter cannot produce a receipt which proves how they voted.\n\n"
          "Q: What will happen if I edit my ballot?\n"
          "A: This will have no effect on the vote you cast."})
      : super(key: key);
  final Map<String, bool> checkedMap;
  final String id;
  final String title;
  final String content;

  @override
  State<BallotAuditCheckBox> createState() => _BallotAuditCheckBoxState();
}

class _BallotAuditCheckBoxState extends State<BallotAuditCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.checkedMap[widget.id] ?? false,
      onChanged: (value) => setState(() {}),
      /* onChanged: (value) => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  content: Text(widget.content, style: Theme.of(context).textTheme.bodyMedium,),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.checkedMap[widget.id] = value!;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Accept'),
                    ),
                  ],
                )) */
    );
  }
}
