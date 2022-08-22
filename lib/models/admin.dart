import 'package:flutter/material.dart';
import 'package:icbapps/helper/auth/auth.dart';

import 'package:icbapps/models/main_admin_model.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({Key? key}) : super(key: key);

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {

  TextEditingController bkash = TextEditingController();
  TextEditingController binary = TextEditingController();
  FireBase fireBase = FireBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Admin"),
      ),
      body: Column(
        children: [
          StreamBuilder<MainAdminModel>(
            stream: fireBase.mainadmindatas(),
              builder: (context, snapshot){
                return snapshot.hasData?Text("${snapshot.data!.bkashnumber}"):CircularProgressIndicator();
              }
          ),
          TextField(
            controller: bkash,
            decoration: InputDecoration(
              hintText: "Bkash",
              border: OutlineInputBorder()
            ),
          ),

          TextField(
            controller: binary,
            decoration: InputDecoration(
                hintText: "Bkash",
                border: OutlineInputBorder()
            ),
          ),

          TextButton(onPressed: ()async{
            await fireBase.mainAdminbkashbinaryadd(bkash.text.trim(), binary.text.trim());

          }, child: Text("add data"))


        ],
      ),
    );
  }
}