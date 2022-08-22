import 'package:flutter/material.dart';
import 'package:icbapps/models/noticemodel.dart';

import '../../helper/auth/auth.dart';


class Noticescreen extends StatefulWidget {
  const Noticescreen({Key? key}) : super(key: key);

  @override
  State<Noticescreen> createState() => _NoticescreenState();
}

class _NoticescreenState extends State<Noticescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notice for today"),),
      body:
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: StreamBuilder<List<NoticeModel>>(
                  stream: FireBase().allNotice(),

                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("notice: ${snapshot.data![index].notice}"),


                            ),
                          );
                        }
                      );

                  }
                ),
              ),
            )

    );
  }
}