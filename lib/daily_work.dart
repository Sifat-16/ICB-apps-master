import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:icbapps/helper/auth/auth.dart';
import 'package:icbapps/models/ModelUser.dart';
import 'package:icbapps/screens/widgets/header_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyWork extends StatefulWidget {
  DailyWork({Key? key, required this.modelUser}) : super(key: key);
  ModelUser modelUser;


  @override
  State<DailyWork> createState() => _DailyWorkState();
}

class _DailyWorkState extends State<DailyWork> {

  FireBase fireBase = FireBase();
  RewardedAd? rewardedAd;
  bool loaded = false;
  int videosToshow = 0;


  @override
  void initState() {
    // TODO: implement initState
    checkValidity();
    super.initState();
  }

  checkValidity()async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formated = formatter.format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    int? showed = prefs.getInt(formated);
    if(showed==null){
      showed = 0;
      videosToshow = 0;
      await prefs.setInt(formated, showed);
    }else{
      setState(() {
        videosToshow = showed!;
      });
    }

  }

  addTosharedPref(int v)async{
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formated = formatter.format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(formated, v);

  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
           SizedBox(
                          height: 250,
                          child: HeaderWidget(
                              240, false, Icons.person_add_alt_1_rounded),
                        ),
          Padding(
            padding:  EdgeInsets.only(top: h*0.1,left: w*0.16),
            child: Text("You have ${5-videosToshow} tasks pending for today", style: GoogleFonts.oleoScript(
                                         color: Colors.white,fontSize: 20,)),
          ),

          Padding(
            padding:  EdgeInsets.only(top: h*0.4,left: w*0.4),
            child: Visibility(
              visible: videosToshow<5?true:false,
              child: TextButton(onPressed: (){
                if(loaded){
                  rewardedAd?.show(onUserEarnedReward: (without, item)async{
                    print("rewarded");
                    final x = await fireBase.rewardUser(widget.modelUser);
                    setState(() {
                      loaded=false;
                      videosToshow+=1;

                    });
                    await addTosharedPref(videosToshow);
                    if(x==true){
                      print("rewarded");
                    }else{
                      print("not rewarded");
                    }
                  });
                }else{
                  RewardedAd.load(
                      adUnitId: "ca-app-pub-3940256099942544/5224354917",
                      request: const AdRequest(),
                      rewardedAdLoadCallback: RewardedAdLoadCallback(
                          onAdLoaded: (ad){
                            setState(() {
                              rewardedAd = ad;
                              loaded=true;
                            });
                          },
                          onAdFailedToLoad: (e){
                            print(e);
                          }
                      )
                  );
                }




              },child: Text(!loaded?"load first":"show Add"),),
            ),
          ),
        ],
      ),
    );
  }
}