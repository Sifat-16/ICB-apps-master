import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


openwhatsapp(BuildContext context) async{
  var whatsapp ="+8801745873169";
  var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
  //var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    // android , web

    if( await canLaunchUrl(Uri.parse(whatsappURl_android))){
      await launchUrl(Uri.parse(whatsappURl_android));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }




}