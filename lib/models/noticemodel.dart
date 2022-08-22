class NoticeModel{
  String? notice;
  bool? valid;
  NoticeModel({this.notice, this.valid});

  NoticeModel.fromJson(Map<String, dynamic> json){
    notice = json["notice"];
    valid = json["valid"];
  }

}