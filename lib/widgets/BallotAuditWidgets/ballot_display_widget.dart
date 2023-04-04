import 'package:flutter/material.dart';
import 'package:mobile_voting_verifier/models/core_3_ballot.dart';
import 'package:mobile_voting_verifier/widgets/BallotAuditWidgets/ballot_audit_checkbox.dart';

class BallotDisplayWidget extends StatefulWidget {
  const BallotDisplayWidget({Key? key, required this.ballotSpec})
      : super(key: key);
  final Core3Ballot ballotSpec;

  @override
  State<BallotDisplayWidget> createState() => _BallotDisplayWidgetState();
}

class _BallotDisplayWidgetState extends State<BallotDisplayWidget> {
  // Track the checked state of each candidate
  Map<String, bool> checkedMap = {};
  bool checked = false;

  List<Widget> buildTableRows(BuildContext context) {
    var tables = <Widget>[];
    for (var candidateList in widget.ballotSpec.lists) {
      List<TableRow> rows = [];
      // Add candidate list
      tables.add(Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[700]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  candidateList.title?.default_ ?? "No title",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ));

      //Create Current row with empty first column
      var curRow = <Widget>[Container()];

      //Add column headers from ballot spec
      curRow.addAll(List.generate(
          candidateList.columnHeaders.length,
          (index) => candidateList.columnHeaders[index].default_ != ""
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(candidateList.columnHeaders[index].default_,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)))
              : Text(candidateList.columnHeaders[index].default_,
                  style: const TextStyle(fontWeight: FontWeight.bold))));

      // Add all widgets in the currentRow as a tableRow to the current
      // candidateList table rows
      rows.add(TableRow(
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        children: curRow,
      ));

      // Add all candidates to the current candidateList table rows
      for (var candidate in candidateList.candidates) {
        checkedMap[candidate.id] = candidate.RECEIVED_MOCK_VOTE;
        List<Widget> cols = [
          Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: BallotAuditCheckBox(
                  checkedMap: checkedMap,
                  id: candidate.id)

          )
        ];
        cols.addAll(List.generate(
            candidate.columns.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    candidate.columns[index].value.value.values.isNotEmpty
                        ? candidate.columns[index].value.value.values
                            .first //TODO should we have a listbuilder here?
                        : candidate.columns[index].value.default_ ?? "No value",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )));

        rows.add(TableRow(children: cols));
      }
      tables.add(Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {0: IntrinsicColumnWidth()},
            border: TableBorder.all(),
            children: rows),
      ));
    }
    tables.add(Row(
      children: [
        BallotAuditCheckBox(
          checkedMap: checkedMap,
          id: widget.ballotSpec.id),
        Text(
          "Your ballot is marked as invalid",
          style: TextStyle(color: Colors.grey[400]),
        )
      ],
    ));
    return tables;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 3,
          color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      widget.ballotSpec.title.default_,
                      style: Theme.of(context).textTheme.displayMedium),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
        Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
              child: Column(
                children: buildTableRows(
                    context), // This may be problematic if rebuilding is done often
              ),
            )),
      ],
    );
  }
}
