import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:icbapps/models/ModelUser.dart';
import 'package:icbapps/screens/widgets/header_widget.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      

      body: Stack(
        
        children: [
        SizedBox(
          height: 250,
          child: HeaderWidget(240, false, Icons.abc_outlined)),
          Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: h*0.1,horizontal: w*0.4),
                child: Text("History",style: GoogleFonts.oleoScript(
            color: Colors.white, fontSize: 20)),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: h*0.1,horizontal: w*0.1),
                child: Row(
                  children: [
                    Container(
                      height: h*0.16,
                      width: w*0.32,
                      decoration: BoxDecoration(
                        color: HexColor('#8A02AE'),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h*0.06,horizontal: w*0.03),
                        child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Daily work",style: GoogleFonts.oleoScript(
    color: Colors.white, fontSize: 10)),
                            Text("Tk: ${widget.modelUser.workbonus}",style: GoogleFonts.oleoScript(
                            color: Colors.white, fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: w*0.15,),
                    Container(
                      height: h*0.16,
                      width: w*0.32,
                      decoration: BoxDecoration(
                        color: HexColor('#8A02AE'),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h*0.06,horizontal: w*0.03),
                        child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Total Point",style: GoogleFonts.oleoScript(
    color: Colors.white, fontSize: 10)),
                            Text("Tk: ${widget.modelUser.balance}",style: GoogleFonts.oleoScript(
                            color: Colors.white, fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: w*0.1),
                child: Row(
                  children: [
                    Container(
                      height: h*0.16,
                      width: w*0.32,
                      decoration: BoxDecoration(
                        color: HexColor('#8A02AE'),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h*0.06,horizontal: w*0.03),
                        child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Withdrawal point",style: GoogleFonts.oleoScript(
    color: Colors.white, fontSize: 10)),
                            Text("Tk: ${widget.modelUser.withdrawal}",style: GoogleFonts.oleoScript(
                            color: Colors.white, fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: w*0.15,),
                    Container(
                      height: h*0.16,
                      width: w*0.32,
                      decoration: BoxDecoration(
                        color: HexColor('#8A02AE'),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: h*0.06,horizontal: w*0.03),
                        child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Reference Point",style: GoogleFonts.oleoScript(
    color: Colors.white, fontSize: 10)),
                            Text("Tk: ${widget.modelUser.reference}",style: GoogleFonts.oleoScript(
                            color: Colors.white, fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ],) );
  }
}