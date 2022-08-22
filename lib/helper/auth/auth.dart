import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:icbapps/models/ModelUser.dart';

import 'package:icbapps/models/main_admin_model.dart';
import 'package:icbapps/models/noticemodel.dart';
import 'package:icbapps/models/recharge_model.dart';
import 'package:icbapps/models/withdraw_model.dart';

class FireBase {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final store = FirebaseFirestore.instance;

  Future<UserCredential> signin(String username, String password) async {
    final x = await auth.signInWithEmailAndPassword(
        email: username, password: password);
    return x;
  }

  Future<UserCredential> signup(String username, String password) async {
    final x = await auth.createUserWithEmailAndPassword(
        email: username, password: password);
    return x;
  }

  Future<String> uploadImage(File imageFile, String fileName) async {
    final x = await storage.ref("profile/$fileName").putFile(imageFile);
    final y = await x.ref.getDownloadURL();
    return y;
  }

  createProfile(ModelUser modelUser, String refarral) async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    modelUser.refarralId = String.fromCharCodes(Iterable.generate(
        6, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    final x = await store
        .collection("userProfile")
        .doc(modelUser.uid)
        .set(modelUser.toJson())
        .onError((error, stackTrace) => false);

    return true;
  }

  Future<ModelUser> myProfile() async {
    ModelUser modelUser = ModelUser();
    final x = await store
        .collection("userProfile")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      modelUser = ModelUser.fromJson(value.data()!);
    });

    print(modelUser.username);
    return modelUser;
  }

  Stream<ModelUser> myProfileStream() {
    return store
        .collection("userProfile")
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((event) => ModelUser.fromJson(event.data()!));
  }

  checkPresenceAndCreate() async {
    final x = await store
        .collection("userProfile")
        .where("username", isEqualTo: "siftan10203099")
        .get()
        .then((value) async {
      if (value.docs.length == 0) {
        final y = await signup("siftan10203099@gmail.com", "01907334326");
        final z = await createProfile(
            ModelUser(uid: y.user!.uid, username: "siftan10203099"), "jajkuj");
      }
    });
  }

  addRefaralToTeam(ModelUser modelUser, String refarral) async {
    if (refarral == null || refarral.length < 6) {
    } else {
      try {
        final y = await store
            .collection("userProfile")
            .where("refarralId", isEqualTo: refarral)
            .get()
            .then((value) async {
          print(value.docs.length);
          final z = store
              .collection("userProfile")
              .doc(value.docs.first.data()["uid"]);
          final l = await z.get();
          print(l.data()!["teamMember"]);
          List<String> x = [];
          double point = 0;
          if (l.data()!["teamMember"] != null) {
            l.data()!["teamMember"].forEach((e) {
              x.add(e);
            });
            x.add(modelUser.uid!);
          }
          double ref = 0;
          if (l.data()!["balance"] != null) {
            point = l.data()!["balance"];
            ref = l.data()!["reference"];
            ref += 500;
            point += 500;
          }
          final k = await z
              .update({"teamMember": x, "balance": point, "reference": ref});
        });
      } catch (e) {
        print("went wrong");
      }
    }
  }

  rewardUser(ModelUser modelUser) async {
    final x = store.collection("userProfile").doc(modelUser.uid);
    final y = await x.get();
    double l = 0;
    if (y.data()!["balance"] != null) {
      l = y.data()!["balance"];
      l += 500;
    } else {
      l += 500;
    }

    await x.update({
      "balance": l,
      "workbonus": y.data()!["workbonus"] + 500
    }).onError((error, stackTrace) => false);

    return true;
  }

  Future<bool> withdrawRequest(WithdrawModel withdrawModel) async {
    final x = await store
        .collection("withdraws")
        .doc()
        .set(withdrawModel.toJson())
        .onError((error, stackTrace) => false);
    return true;
  }

  Stream<List<WithdrawModel>> allwithdraws(ModelUser modelUser) {
    return store
        .collection("withdraws")
        .where("uid", isEqualTo: modelUser.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => WithdrawModel.fromJson(e.data())).toList());
  }

  addLastWithdraw() async {
    final z = store.collection("userProfile").doc(auth.currentUser!.uid);
    await z.update({"lastWithdraw": DateTime.now()});
  }

  Future<bool> rechargeTobalance(String amount, String transactionId) async {
    final x = await store
        .collection("recharges")
        .doc()
        .set(RechargeModel(
                uid: auth.currentUser!.uid,
                amount: amount,
                transactionId: transactionId)
            .toJson())
        .onError((error, stackTrace) => false);
    return true;
  }

  mainAdminbkashbinaryadd(String bkash, String binary) async {
    final x = await store.collection("mainadmin").doc("staticdata").set(
        MainAdminModel(bkashnumber: bkash, binaryaccount: binary).toJson());
  }

  Stream<MainAdminModel> mainadmindatas() {
    return store
        .collection("mainadmin")
        .doc("staticdata")
        .snapshots()
        .map((event) => MainAdminModel.fromJson(event.data()!));
  }

  Stream<List<NoticeModel>> allNotice() {
    return store
        .collection("notice")
        .snapshots()
        .map((event) =>
        event.docs.map((e) => NoticeModel.fromJson(e.data())).toList());
  }

}
