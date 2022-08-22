import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';

import 'package:icbapps/models/withdraw_model.dart';

class WithdrawReport extends StatefulWidget {
  WithdrawReport({Key? key, required this.modelUser}) : super(key: key);

  ModelUser modelUser;

  @override
  State<WithdrawReport> createState() => _WithdrawReportState();
}

class _WithdrawReportState extends State<WithdrawReport> {
  FireBase fireBase = FireBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Withdraw Report"),
      ),
      body: Center(
        child: StreamBuilder<List<WithdrawModel>>(
            stream: fireBase.allwithdraws(widget.modelUser),

            builder: (context, snapshot){
                return snapshot.hasData? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text("${snapshot.data![index].amount}"),
                        subtitle: Text("${snapshot.data![index].granted}"),
                      );
                    }
                ):CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}