class ModelUser{
  String? username;
  String? uid;
  String? email;
  String? fullName;
  String? refarralId;
  String? profileImage;
  List<String> teamMember=[];
  double balance=0.0;
  double workbonus = 0.0;
  double withdrawal = 0.0;
  double reference = 0.0;
  DateTime? lastWithdraw;


  ModelUser({this.username, this.uid, this.email, this.fullName, this.refarralId, this.profileImage});

  Map<String, dynamic> toJson(){

    return {
      "username":username,
      "uid":uid,
      "email":email,
      "fullName":fullName,
      "refarralId":refarralId,
      "profileImage":profileImage,
      "teamMember":teamMember,
      "balance":balance,
      "workbonus":workbonus,
      "withdrawal":withdrawal,
      "reference":reference,
      "lastWithdraw":lastWithdraw
    };
  }

  ModelUser.fromJson(Map<String, dynamic> json){
    try{
      username = json["username"];
    }catch(e){
        print("username");
    }
    try{
      uid = json["uid"];
    }catch(e){
        print("uid");
    }
    try{
      email = json["email"];
    }catch(e){
        print("email");
    }
    try{
      fullName = json["fullName"];
    }catch(e){
      print("fullname");

    }
    try{
      refarralId = json["refarralId"];
    }catch(e){
        print("refarralid");
    }
    try{
      profileImage = json["profileImage"];
    }catch(e){
        print("profileimage");
    }

    try{

      if(json["teamMember"]!=null){
        teamMember = [];
        json["teamMember"].forEach((e){
            teamMember.add(e);
        });
      }else{
        teamMember = [];
      }

    }catch(e){
      //print(json["teamMember"]);
        print("teamMemberrrrrr");
    }

    try{
      balance = json["balance"];
    }catch(e){
      print("balance");
    }
    try{

      workbonus = json["workbonus"];

    }catch(e){

    }
    try{

      withdrawal = json["withdrawal"];

    }catch(e){

    }
    try{

      reference = json["reference"];

    }catch(e){

    }

    try{
      //print(json["lastWithdraw"]);
      lastWithdraw = DateTime.fromMillisecondsSinceEpoch(json["lastWithdraw"].seconds*1000);

    }catch(e){
      print("getting problem");
    }




  }
}