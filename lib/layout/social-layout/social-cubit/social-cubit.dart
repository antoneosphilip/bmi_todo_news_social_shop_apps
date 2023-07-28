


import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-states.dart';
import 'package:shopapp/model/social-model/social-model.dart';
import 'package:shopapp/modules/social-app/Home-screen/Home-screen.dart';
import 'package:shopapp/modules/social-app/Home-screen/comment.dart';
import 'package:shopapp/modules/social-app/Home-screen/like2.dart';
import 'package:shopapp/modules/social-app/chats-screen/chats-details/chat-model.dart';
import 'package:shopapp/modules/social-app/chats-screen/chats-screen.dart';
import 'package:shopapp/modules/social-app/model-message/model-messsage.dart';
import 'package:shopapp/modules/social-app/new-post/new-post.dart';
import 'package:shopapp/modules/social-app/users-screen/users-screen.dart';

import '../../../Network/remote/diohelper.dart';
import '../../../model/social-model/new-post-model/new-post-model.dart';
import '../../../modules/social-app/feedsscreen/feeds-screen.dart';
import '../../../modules/social-app/settings-screen/settings-screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class sociallayoutcubit extends Cubit<shoplayoutstates> {
  sociallayoutcubit() :super(shoplayoutintialstates());


  List<crateusermodel>? users;

  static sociallayoutcubit get(context) => BlocProvider.of(context);
  crateusermodel? model;

  void getuserdata() {
    emit(shoplayoutugetuserloadingtates());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      model = crateusermodel.fromjson(value.data()!);

      emit(shoplayoutgetdatesucessstates());
    }).catchError((error) {
      emit(shoplayoutgetdateerrorstates());
    });
  }


  int currentindex = 0;
  List<Widget> screens = [
    Homescreen(),
    chatsscreen(),
    newpostscreen(),
    feedsscreen(),
    settingsscreen(),
  ];

  void changebottomnav(int index, context) {
    if (index == 1) {
      getusers();
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => newpostscreen()),
      );
      emit(shoplayoutaddpoststates());
    }
    else {
      currentindex = index;
      emit(shoplayoutbottomsheetstates());
    }
  }

  List<Text> titles = [
    Text("Home"),
    Text("Chats"),
    Text("Add posts"),

    Text("Users"),
    Text("Settings"),


  ];
  File? imageprofile;
  var pickerprofile = ImagePicker();


  // Implementing the image picker
  Future openImagePicker() async {
    final pickedImageprofile =
    await pickerprofile.pickImage(source: ImageSource.gallery);
    if (pickedImageprofile != null) {
      imageprofile = File(pickedImageprofile.path);
      emit(shoplayoutprofilesuccessstates());
    }
  }

  File? imagecover;

  var pickercover = ImagePicker();


  // Implementing the image picker
  Future openImagePickecoverr() async {
    final pickedImage =
    await pickercover.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagecover = File(pickedImage.path);
      emit(shoplayoutcovererroetates());
    }
  }

  void updateuploadprofile({
    required name,
    required bio,
    required phone,
  }) {
    emit(shoplayoutuupateuserloadingstates());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(imageprofile!.path)
        .pathSegments
        .last}').putFile(imageprofile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updatesuerdata(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        print(error.toString());
      });
    }).catchError((error) {});
  }


  void updateuploadcover({

    required name,
    required bio,
    required phone,
  }) {
    emit(shoplayoutuupateuserloadingstates());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(imagecover!.path)
        .pathSegments
        .last}').putFile(imagecover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);

        updatesuerdata(name: name, phone: phone, bio: bio, cover: value);
      }).
      catchError((error) {});
    }).catchError((error) {});
  }

  void updatesuerdata({
    required name,
    required bio,
    required phone,
    image,
    cover,


  }) {
    emit(shoplayoutuupateuserloadingstates());

    crateusermodel model2 = crateusermodel(

      name: name,
      phone: phone,
      uId: model?.uId,
      email: model?.email,
      isEmailVerified: false,
      image: image ?? model?.image,
      bio: bio,
      cover: cover ?? model?.cover,

    );

    FirebaseFirestore.instance.collection('user').doc(uId).update(
        model2.tomap()).then((value) {
      getuserdata();
      emit(shoplayoutuupateuserloadingstates());
    }).catchError((error) {
      emit(shoplayoutuupateusererrorstates());
    });
  }

  File? imagepost;

  var pickerprofilepost = ImagePicker();


  // Implementing the image picker
  Future openImagePickeepost() async {
    final pickedImage =
    await pickerprofilepost.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagepost = File(pickedImage.path);
      emit(shoplayoutcovererroetates());
    }
  }

  void uploadpost({

    required date,
    required text,


  }) {
    emit(shoplayoutucreatepostloadingstates());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(imagepost!.path)
        .pathSegments
        .last}').putFile(imagepost!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createusuerpost(text: text, date: date, postimage: value);
      }).
      catchError((error) {});
    }).catchError((error) {});
  }

  void createusuerpost({
    date,
    text,
    id,
    postimage
  }) {
    emit(shoplayoutucreatepostloadingstates());
    newpostmodel model2 = newpostmodel(
      name: model?.name,
      uId: model?.uId,
      date: date,
      text: text,
      image: model?.image,
      postimage: postimage ?? '',

    );

    FirebaseFirestore.instance.collection('posts').add(
        model2.tomap()).then((value) {
      emit(shoplayoutuppostsuccesstates());
    }).catchError((error) {
      emit(shoplayoutuploadposterroestates(error));
    });
    commenttitle.add(text);
    print(commenttitle.length);
  }

  void closephoto() {
    imagepost = null;
    emit(shoplayoutuclosephotostates());
  }

  List<newpostmodel> posts = [];
  List<String> likeposts = [];
  List<String> commentposts = [];

  List<int> likepostsnumber = [];
  List<likemodel> commentnumber = [];
  List<likemodel> commentnumber2 = [];
  List<Map<String, dynamic>> commentnumber3 = [];


  List<commentmodel> likeboolnumber = [];
  List<bool> likeboolnumber2 = [];
  List<TextEditingController> text = [];


  newpostmodel? postmodel;

//   likeboolnumber.add(likemodel.fromjson(element.data()));
//             print(modellike?.like);
  void getuserposts() {

    emit(shoplayoutugetuserloadingtates());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      posts = [];

      event.docs.forEach((element) {
        likeposts.add(element.id);
        posts.add(newpostmodel.fromjson(element.data()));

        element.reference.collection('likes').snapshots().listen((event) {
          likepostsnumber.add(event.docs.length);
          emit(shoplayoutugetuserpostsuccesstates());

          event.docs.forEach((element) {

            likeboolnumber.add(commentmodel.fromjson(element.data()));
            print("aaaaaaaaaaa");
            print(likeboolnumber[1].like2);
            emit(shoplayoutlikelovetates());
          });
          emit(shoplayoutugetusersucceesstates());
        });
        emit(shoplayoutugetusererrortates());
        element.reference.collection('comments').snapshots().listen((event) {
          commentposts.add(element.id);
          // if(sociallayoutcubit.get(context).commentposts[index]!='')

          event.docs.forEach((element) {
            comment.add(element.data().length);
            print(element.data().toString());
            emit(shoplayoutconnebtlovetates());
          });
          emit(shoplayoutcommentlovetates());
        });
        // emit(shoplayoutgetdatesucessstates());
        // likeposts.add(element.id);

        // element.reference.collection('comments').snapshots().listen((event) {
        //   commentposts.add(element.id);
        //   // if(sociallayoutcubit.get(context).commentposts[index]!='')
        //
        //   event.docs.forEach((element) {
        //       commentnumber2.add(likemodel.fromjson(element.data()));
        //     print(commentnumber2[0].like[0].length);
        //     emit(shoplayoutconnebtlovetates());
        //   });
        //   emit(shoplayoutcommentlovetates());
        // });
        // emit(shoplayoutgetdatesucessstates());
      });
    },


    );
  }
  void getlikes(){


    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {

      event.docs.forEach((element) {


      });
    },


    );


  }
  void getusers() {
    users = [];
    if (users?.length == 0);
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != model?.uId)
          users?.add(crateusermodel.fromjson(element.data()));
        emit(shoplayoutugetusersoadingstates());
      });
    }).then((value) {
      emit(shoplayoutugetuserssuccesstates());
    }).catchError((error) {
      emit(shoplayoutgetuserserroestates(error.toString()));
    });
  }

  void commentinpost({required id}) {


  }

  bool like = true;

  void postlike(String id) {

    FirebaseFirestore.instance.collection('posts').doc(id).collection('likes')
        .doc(model?.uId).set(
        {
          'like': true,

        })

        .then((value) {
      FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
        event.docs.forEach((element) {
          likepostsnumber=[];

          element.reference.collection('likes').snapshots().listen((event) {
            likepostsnumber.add(event.docs.length);
            emit(shoplayoutugetuserpostsuccesstates());

            event.docs.forEach((element) {

              likeboolnumber.add(commentmodel.fromjson(element.data()));
              emit(shoplayoutlikelovetates());
            });
            emit(shoplayoutugetusersucceesstates());
          });
          emit(shoplayoutugetusererrortates());
          // element.reference.collection('comments').snapshots().listen((event) {
          //   commentposts.add(element.id);
          //   // if(sociallayoutcubit.get(context).commentposts[index]!='')
          //
          //   event.docs.forEach((element) {
          //       commentnumber2.add(likemodel.fromjson(element.data()));
          //     print(commentnumber2[0].like[0].length);
          //     emit(shoplayoutconnebtlovetates());
          //   });
          //   emit(shoplayoutcommentlovetates());
          // });
          // emit(shoplayoutgetdatesucessstates());
          // likeposts.add(element.id);
          //
          // element.reference.collection('likes').snapshots().listen((event) {
          //   likepostsnumber.add(event.docs.length);
          //   emit(shoplayoutugetuserpostsuccesstates());
          //
          //   event.docs.forEach((element) {
          //     likeboolnumber.add(commentmodel.fromjson(element.data()));
          //     print(likeboolnumber.toString());
          //     emit(shoplayoutlikelovetates());
          //   });
          //   emit(shoplayoutugetusersucceesstates());
          // });
          // emit(shoplayoutugetusererrortates());
          // // element.reference.collection('comments').snapshots().listen((event) {
          // //   commentposts.add(element.id);
          // //   // if(sociallayoutcubit.get(context).commentposts[index]!='')
          // //
          // //   event.docs.forEach((element) {
          // //       commentnumber2.add(likemodel.fromjson(element.data()));
          // //     print(commentnumber2[0].like[0].length);
          // //     emit(shoplayoutconnebtlovetates());
          // //   });
          // //   emit(shoplayoutcommentlovetates());
          // // });
          // // emit(shoplayoutgetdatesucessstates());
        });
      },


      );
      // FirebaseFirestore.instance.collection('posts').doc(id).collection('likes').doc(model?.uId).snapshots().listen((event) {
      //   likepostsnumber.add(event.id.length);
      //
      //   // event.docs.forEach((element) {
      //   //   likeposts.add(element.id);
      //   //
      //   //   element.reference.collection('likes').snapshots().listen((event) {
      //   //     emit(shoplayoutugetuserpostsuccesstates());
      //   //
      //   //     event.docs.forEach((element) {
      //   //       likeboolnumber.add(commentmodel.fromjson(element.data()));
      //   //       print(likeboolnumber.toString());
      //   //       emit(shoplayoutlikelovetates());
      //   //     });
      //   //     emit(shoplayoutugetusersucceesstates());
      //   //   });
      //   //   emit(shoplayoutugetusererrortates());
      //   //   // element.reference.collection('comments').snapshots().listen((event) {
      //   //   //   commentposts.add(element.id);
      //   //   //   // if(sociallayoutcubit.get(context).commentposts[index]!='')
      //   //   //
      //   //   //   event.docs.forEach((element) {
      //   //   //       commentnumber2.add(likemodel.fromjson(element.data()));
      //   //   //     print(commentnumber2[0].like[0].length);
      //   //   //     emit(shoplayoutconnebtlovetates());
      //   //   //   });
      //   //   //   emit(shoplayoutcommentlovetates());
      //   //   // });
      //   //   // emit(shoplayoutgetdatesucessstates());
      //   // });
      // },
      //
      //
      // );
      // emit(shoplayoutuuuutates());

//       FirebaseFirestore.instance.collection('posts').doc(id).collection('likes').doc(model?.uId).get().then((
//           event) {
//
//         print(event.id);
//         likepostsnumber.add(event.data()!.length);
//         print(like);
// emit(shoplayoutsendlikestates());
//
//         // event.docs.forEach((element) {
//         //   element.reference.collection('likes').snapshots().listen((event) {
//         //     likepostsnumber.add(event.docs.length);
//         //     emit(shoplayoutulikeuccesstates());
//         //
//         //     event.docs.forEach((element) {
//         //       likeboolnumber.add(commentmodel.fromjson(element.data()));
//         //       print(likeboolnumber.toString());
//         //     });
//         //     emit(shoplayoutlike2states());
//         //   });
//         //   emit(shoplayoutlike3states());
//         //   // element.reference.collection('comments').snapshots().listen((event) {
//         //   //   commentposts.add(element.id);
//         //   //   // if(sociallayoutcubit.get(context).commentposts[index]!='')
//         //   //
//         //   //   event.docs.forEach((element) {
//         //   //       commentnumber2.add(likemodel.fromjson(element.data()));
//         //   //     print(commentnumber2[0].like[0].length);
//         //   //     emit(shoplayoutconnebtlovetates());
//         //   //   });
//         //   //   emit(shoplayoutcommentlovetates());
//         //   // });
//         //   // emit(shoplayoutgetdatesucessstates());
//         // });
//       },
//
//
//       );
      emit(shoplayoutcccctates());

      like = !like;


    }).catchError((error) {
      emit(shoplayoutuplikepostterroestates(error.toString()));
    });
  }

  bool x = true;

  // // bool? word(index) {
  //
  //
  //    if (likeboolnumber[index] == "{like: true}") {
  //
  //       x = true;
  //       emit(shoplayoutlikeo1successtates());
  //
  //    }
  //
  //    if (likeboolnumber[index] == "{like: false}") {
  //     x=false;
  //     likeboolnumber[index] = "{like: true}";
  //     emit(shoplayoutlike2successtates());
  //
  //    }
  //
  //      emit(shoplayoutlikeotruesuccesstates());
  //    return x;
  //
  //  }
  List<String> commenttitle = [];
  List<chatmodel> messagelist = [];
  List<int> comment=[];

  void postcomment(String id, text) {
    commenttitle.add(text);
    print(commenttitle);
    print(id);
    FirebaseFirestore.instance.collection('posts').doc(id).collection(
        'comments')
        .doc(model?.uId).set(
        {
          'comment': commenttitle,
        })

        .then((value) {

      emit(shoplayoutlikeostsuccesstates());
    }).catchError((error) {
      emit(shoplayoutuplikepostterroestates(error.toString()));
    });
  }
  void getcomment(){


  }

  TextEditingController ? textediting(commentcontroller, context, index,
      index2) {
    commentcontroller.text = sociallayoutcubit
        .get(context)
        .commentnumber2[index].like.toString();
    return commentcontroller;
  }

  void setmessage({required date, required recieverid, required text}) {
    chatmodel chat = chatmodel(
      date: date,
      senderid: model?.uId,
      recieverid: recieverid,
      Text: text,
    );
    print(model?.uId);
    FirebaseFirestore.instance.collection('user').doc(model?.uId).collection(
        'chats').doc(recieverid).collection('message').
    add(chat!.tomap()).
    then((value) {
      emit(shoplayoutsendmessagesuccesstates());
    }).catchError((error) {
      emit(shoplayoutsendmessageerrorsstates());
    });

    FirebaseFirestore.instance.collection('user').doc(recieverid).collection(
        'chats').doc(model?.uId).collection('message').
    add(chat!.tomap()).
    then((value) {
      emit(shoplayoutrecievemessageuccesstates());
    }).catchError((error) {
      emit(shoplayoutrecievemessageerrortates());
    });
  }

  void getmessage({required reserveid}) {
    FirebaseFirestore.instance.collection('user').doc(model?.uId).collection(
        'chats').doc(reserveid).collection('message')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messagelist = [];

      event.docs.forEach((element) {
        messagelist.add(chatmodel.fromjson(element.data()));
        print(messagelist[0].Text);
      });
      emit(shoplayoutgetemessageerrortates());
    });
  }

  message?messagemodel;

  void messagesend({
    required String to,
  }) {
    Diohelper.postdata(
        url: 'https://fcm.googleapis.com/fcm/send',
        data: {
          "to": "${token2}"
        })?.then((value) {
      messagemodel = message.fromJson(value?.data);
      print(messagemodel?.data);
      emit(shoplayoutsendmessagemodeksuccessstates());
    }).catchError((error) {
      emit(shoplayoutsendmessageerrorstates());
      print(error);
    });
  }

  static Future<bool> sendFcmMessage(String title, String message,to) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
        "key=AAAAK0-A6Ok:APA91bEY56LfSgzJyyJeENdbkZus0OQxD6t1J5U0CVZAuvI7wXV8rVR7QWWBJh5klt3B-FNtJd0ubaod-HcphIs7cv9dGfbtLs83-f0TXW8XuCatVAUSPfRAhCBC_BRdZrb6QGSQSVbS",
      };
      var request = {
        "notification": {
          "title": title,
          "text": message,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        "to": to,
      };

      var client = new Diohelper();
      var response =
      await Diohelper.putdata(
          url: url,
          data: {
            "to": "${to}",

            "notification" : {
              "body" : message,
              "content_available" : true,
              "priority" : "high",
              "subtitle":"Elementary School",
              "Title":title
            },
            "android": {
              "priority" : "high",

              "notification" : {
                "body" : message,
                "content_available" : true,
                "priority" : "high",
                "subtitle":"Elementary School",
                "Title":title
              }
            },

            "data" : {
              "priority" : "high",
              "sound":"app_sound.wav",
              "content_available" : true,
              "bodyText" : "New Announcement assigned",
              "organization" :"Elementary school"
            }


          })?.then((value) {
        print(value?.data);
      });
      return true;
    } catch (e, s) {
      print(e);
      return false;
    }
  }

  void gettoken() {
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    late String currentToken;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _messaging.getToken().then((value) {
      print(value);
      currentToken = value!;
      emit(shoplayoutsendtokenrrorstates());
      FirebaseFirestore.instance
          .collection('user')
          .doc('rEo0Gx3Be1TJPFLHFm2xsDPy3UT2')
          .update({'token': value!, 'createdAt': DateTime.now()});
    });

  }
}