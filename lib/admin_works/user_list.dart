import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/user.dart';
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List<AppUser> userList = [];
  bool isLoading = true;
  getUserList()async{
    FirebaseFirestore.instance.collection('users').where('phone_number',isNotEqualTo: sharedObjectsGlobal.userGlobal.phone_number).get().then((querySnapshot){
      querySnapshot.docs.forEach((doc) {
        AppUser appUser = AppUser.fromJson(doc);
        userList.add(appUser);
      });
      print("comming");
      setState(() {
        isLoading = false;
      });

    });
  }
  changeStatus(AppUser user,bool val)async{
    FirebaseFirestore.instance.collection('users').doc(user.phone_number).update({
      'status': val,
    });
    userList.forEach((AppUser value) {
      if(value.phone_number == user.phone_number){
        value.status = val;
      }
    });
    setState(() {});
  }
  @override
  void initState() {
    getUserList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle titleVal=TextStyle(
      fontFamily: "Mina",
      fontSize: 18*widthMultiplier,fontWeight: FontWeight.w800,
      color:sharedObjectsGlobal.deepGreen,
    );
    TextStyle subtitleVal=TextStyle(
      fontFamily: "Mina",
      fontSize: 12*widthMultiplier,fontWeight: FontWeight.w600,
      color:sharedObjectsGlobal.deepGreen,
    );
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background-low-opacity.png"),
                  fit: BoxFit.cover
              )
          ),
        ),

        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 25*heightMultiplier),
        //   child: Material(
        //     color: Colors.transparent,
        //
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //        children: [
        //          IconButton(icon: Icon(Icons.arrow_back_ios,color: sharedObjectsGlobal.deepGreen,size: 22*widthMultiplier ,),
        //            onPressed: (){
        //            print("hello");
        //              Navigator.pop(context);
        //            },),
        //
        //
        //       ],
        //     ),
        //   ),
        // ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: isLoading? Container(
              height: height,width: width,
              child: Center(child: sharedObjectsGlobal.circularProgressCustomize,),
            ): Column(
              children: [
                SizedBox(height: 25*heightMultiplier,),
                Text("User List",style: TextStyle(fontFamily: "Mina",fontSize: 25*widthMultiplier,fontWeight: FontWeight.bold,color: sharedObjectsGlobal.deepGreen),),
                SizedBox(height: 40*heightMultiplier,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userList.length,
                  itemBuilder: (context,index){
                    AppUser singleAppUser = userList[index];
                    bool userStatus = singleAppUser.status;
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(40,5, 20, 5),
                          height: 170*heightMultiplier,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xfff3f5f7)
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(100,20,20,20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Container(
                                        width: 110,
                                        child: Text(singleAppUser.user_name,maxLines: 2,overflow: TextOverflow.ellipsis,style: titleVal,)),
                                    CupertinoSwitch(
                                      value: userStatus,
                                      onChanged: (value) {
                                        changeStatus(singleAppUser,value);
                                        // setState(() {
                                        //   userStatus = !userStatus;
                                        // });
                                      },
                                    ),

                                  ],
                                ),
                                Text(singleAppUser.phone_number,style: TextStyle(
                                  fontFamily: "Mina",
                                  fontSize: 12*widthMultiplier,fontWeight: FontWeight.w500,
                                  color:Colors.grey,
                                ),),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC9D8B6),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(singleAppUser.division,style: subtitleVal,),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC9D8B6),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(singleAppUser.district,style: subtitleVal,),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 15,
                          bottom: 15,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 110,
                                child: Image.network(
                                    singleAppUser.imageUrl,
                                    fit:BoxFit.cover
                                ),
                              )
                          ),
                        )

                      ],
                    );
                  },
                ),
                SizedBox(height: 30*heightMultiplier,),
              ],
            ),
          ),
        )
      ],
    );
  }
}
