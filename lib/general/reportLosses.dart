import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackthecause/utils/Constants.dart';
import 'package:hackthecause/utils/Routes.dart';
import 'package:hive/hive.dart';

class ReportLosses extends StatefulWidget {
  @override
  _ReportLossesState createState() => _ReportLossesState();
}

class _ReportLossesState extends State<ReportLosses> {
  String businessName = "";
  int approxLoss = 0;
  int income = 0;

  final businessController = TextEditingController();
  final lossController = TextEditingController();
  final incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Divider(
                  color: Colors.transparent,
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff4C46D3),
                    ),
                  ),
                ),
                Text("Report Damages", style: loginHeadingText),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.transparent,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Name of Business",
                        hintStyle:
                            TextStyle(fontSize: 20, fontFamily: "Poppins")),
                    controller: businessController,
                    showCursor: true,
                    style: loginInputText,
                  ),
                  height: 30,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    "Report Approximate financial loss during pandemic",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Color(0xff4C46D3),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: lossController,
                    showCursor: true,
                    style: loginInputText,
                  ),
                  height: 30,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter Annual Income",
                        hintStyle:
                            TextStyle(fontSize: 20, fontFamily: "Poppins")),
                    controller: incomeController,
                    showCursor: true,
                    style: loginInputText,
                  ),
                  height: 30,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.2),
                      decoration: loginButtonDecoration,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Center(
                        child: Text("Next", style: loginButtonText),
                      ),
                    ),
                  ),
                  onTap: () async {
                    try {
                      businessName = businessController.text;
                      income = int.parse(incomeController.text);
                      approxLoss = int.parse(lossController.text);
                    } catch (err) {}
                    if (businessName != "" && income != 0 && approxLoss != 0) {
                      final infoBox = await Hive.openBox('info');
                      await infoBox.put('businessName', businessName);
                      await infoBox.put('income', income);
                      await infoBox.put('loss', approxLoss);
                      if (approxLoss <= 500000)
                        Routes.sailor.navigate("/verified",
                            params: {'isApplicable': true});
                      else
                        Routes.sailor.navigate("/verified",
                            params: {'isApplicable': false});
                    } else {
                      Fluttertoast.showToast(
                        msg:
                            "Please enter all details or check entered phone number",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}