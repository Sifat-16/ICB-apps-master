import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/main_admin_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';




class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  FireBase fireBase = FireBase();
  TextEditingController amount = TextEditingController();
  TextEditingController transactionId = TextEditingController();
 final List<String> items = [
  '6 Doller',
  '10 Doller',
  '25 Doller',
  '40 Doller',
];
String? selectedValue;
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Recharge", style: GoogleFonts.oleoScript(
                                                color: Colors.white)),
          bottom:  TabBar(tabs: [
              Tab(child: Text("Bkash", style: GoogleFonts.oleoScript(
                                                color: Colors.white)),),
              Tab(child: Text("Roket", style: GoogleFonts.oleoScript(
                                                color: Colors.white)),),
              Tab(child: Text("Nogod", style: GoogleFonts.oleoScript(
                                                color: Colors.white)),),
              Tab(child: Text("Binance", style: GoogleFonts.oleoScript(
                                                color: Colors.white)),),
              ]),
        ),
        body: TabBarView(children: [
        SizedBox(height: 200,
        child: Column(
          children: [
            StreamBuilder<MainAdminModel>(
              stream: fireBase.mainadmindatas(),
              builder: (context, snapshot) {
                return snapshot.hasData?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: (){
                    Clipboard.setData(ClipboardData(
                        text: snapshot
                            .data!.bkashnumber))
                        .then((value) {
                      final snackbar = SnackBar(
                          content: Text(
                              "Copied: ${snapshot.data!.bkashnumber}"));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackbar);
                    });
                  }, child: Text("Send Money to this number ${snapshot.data!.bkashnumber}")),
                ):const CircularProgressIndicator();
    
              }
            ),
     DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Pakage',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;

            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
     Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: transactionId,
                decoration: const InputDecoration(
                  hintText: "input your transactionId",
                    border: OutlineInputBorder()
                ),
    
              ),
            ),
    
            ElevatedButton(onPressed: (){
              fireBase.rechargeTobalance(amount.text.trim(), transactionId.text.trim()).then((value){
                print(value);
              });
    
            }, child: const Text("Send request"))
    
          ],
        ),
        ),
        SizedBox(height: 200,
        child: Column(
          children: [
            StreamBuilder<MainAdminModel>(
              stream: fireBase.mainadmindatas(),
              builder: (context, snapshot) {
                return snapshot.hasData?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Send Money to this number ${snapshot.data!.bkashnumber}"),
                ):const CircularProgressIndicator();
    
              }
            ),
        DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
     Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: transactionId,
                decoration: const InputDecoration(
                  hintText: "input your transactionId",
                    border: OutlineInputBorder()
                ),
    
              ),
            ),
    
            ElevatedButton(onPressed: (){
              fireBase.rechargeTobalance(selectedValue==items[0]?"6":selectedValue==items[1]?"10":selectedValue==items[2]?"25":"40", transactionId.text.trim()).then((value){
                print(value);
              });
    
            }, child: const Text("Send request"))
    
          ],
        ),),
        SizedBox(height: 200,
        child: Column(
          children: [
            StreamBuilder<MainAdminModel>(
              stream: fireBase.mainadmindatas(),
              builder: (context, snapshot) {
                return snapshot.hasData?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Send Money to this number ${snapshot.data!.bkashnumber}"),
                ):const CircularProgressIndicator();
    
              }
            ),
   DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: transactionId,
                decoration: const InputDecoration(
                  hintText: "input your transactionId",
                    border: OutlineInputBorder()
                ),
    
              ),
            ),
    
            ElevatedButton(onPressed: (){
              fireBase.rechargeTobalance(amount.text.trim(), transactionId.text.trim()).then((value){
                print(value);
              });
    
            }, child: const Text("Send request"))
    
          ],
        ),
        ),SizedBox(height: 200,
        child: Column(
          children: [
            StreamBuilder<MainAdminModel>(
              stream: fireBase.mainadmindatas(),
              builder: (context, snapshot) {
                return snapshot.hasData?const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Binance acount : bc1q7x8xm62c2e9aa6s96h20086cl80y7er7up4k79"),
                ):const CircularProgressIndicator();
    
              }
            ),
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: transactionId,
                decoration: const InputDecoration(
                  hintText: "input your transactionId",
                    border: OutlineInputBorder()
                ),
    
              ),
            ),
    
            ElevatedButton(onPressed: (){
              fireBase.rechargeTobalance(amount.text.trim(), transactionId.text.trim()).then((value){
                print(value);
              });
    
            }, child: const Text("Send request"))
    
          ],
        ),
        )
        
        
        
        ]),
      ),
    );
  }
}