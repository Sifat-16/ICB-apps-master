import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';

import 'package:icbapps/models/withdraw_model.dart';

class WithDrawRequest extends StatefulWidget {
  WithDrawRequest({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

  @override
  State<WithDrawRequest> createState() => _WithDrawRequestState();
}

class _WithDrawRequestState extends State<WithDrawRequest> {
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();
  bool canWithdraw = false;
  bool result = false;
  bool processing = false;
  FireBase fireBase = FireBase();

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.modelUser.lastWithdraw);
    //print(DateTime.now().difference(widget.modelUser.lastWithdraw!).inDays);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw Request"),
      ),
      body: widget.modelUser.lastWithdraw == null ||
              DateTime.now().difference(widget.modelUser.lastWithdraw!).inDays >
                  30
          ? Column(
              children: [
                Text("Your current balance: ${widget.modelUser.balance}"),
                TextField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Bkash Number", border: OutlineInputBorder()),
                ),
                TextField(
                  onChanged: (v) {
                    double k = double.parse(v);
                    if (k <= widget.modelUser.balance) {
                      setState(() {
                        canWithdraw = true;
                      });
                    } else {
                      setState(() {
                        canWithdraw = false;
                      });
                    }
                  },
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Amount you want to withdraw",
                      border: OutlineInputBorder()),
                ),
                Visibility(
                  visible: canWithdraw,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          processing = true;
                        });
                        fireBase
                            .withdrawRequest(WithdrawModel(
                                uid: widget.modelUser.uid,
                                amount: double.parse(amount.text.trim()),
                                number: number.text.trim()))
                            .then((value) {
                          setState(() {
                            result = value;
                          });
                        });
                        fireBase.addLastWithdraw();
                        fireBase.myProfile().then((value) {
                          setState(() {
                            widget.modelUser = value;
                          });
                        });
                      },
                      child: const Text("Withdraw")),
                ),
                Visibility(
                  visible: processing,
                  child: result
                      ? const Text("Your request is received, wait for the approval")
                      : const Text("Processing request"),
                )
              ],
            )
          : const Center(
              child: Text("Cant withdraw now"),
            ),
    );
  }
}
