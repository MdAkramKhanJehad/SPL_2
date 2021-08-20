import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/question.dart';
import 'single_question_layout/single_question_header_section.dart';
import 'single_question_layout/single_question_middle_section.dart';
import 'upload_question/upload_question_template_page.dart';

class QAPage extends StatefulWidget {

  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<Question> questionList=[];
  int perPageLimit = 5;
  bool queryForMore = true;
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    var query = FirebaseFirestore.instance.collection('questions').where('visibility',isEqualTo: true).orderBy('postDate',descending: true).limit(perPageLimit);
    fetchPaginatedData(query);
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels ==scrollController.position.maxScrollExtent && queryForMore){
        var query = FirebaseFirestore.instance.collection('questions').where('visibility',isEqualTo: true).orderBy('postDate',descending: true)
            .startAfter([questionList[questionList.length-1].questionPostedDate])
            .limit(perPageLimit);
        fetchPaginatedData(query);
      }
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  fetchPaginatedData(query) {
    query
        .get()
        .then((querySnapshot){
          if(querySnapshot.docs.length ==0){
            queryForMore = false;
          }
          querySnapshot.docs.forEach((doc){
          Question q = Question.fromJson(doc);
         questionList.add(q);
       });
          setState(() {});
    });
  }
  Widget  askCommunityButton(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> QuestionTemplate() ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
          color:  sharedObjectsGlobal.deepGreen,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.pen,color: Colors.white,size: 15*sharedObjectsGlobal.widthMultiplier,),
            SizedBox(width: 10,),
            Text("Ask Community",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Mina",height: 2,fontSize: 16*sharedObjectsGlobal.widthMultiplier,color: Colors.white),),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double heightMultiplier = height/712;
    double widthMultiplier= width/360;
    TextStyle appBarTitleStyle=TextStyle(
      fontFamily: "Mina",
      letterSpacing: 0,
      fontSize: 18*widthMultiplier,fontWeight: FontWeight.w800,color:sharedObjectsGlobal.deepGreen,);
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/home-page-bg.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor:  Colors.transparent,
            backwardsCompatibility: false,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            title: Text("Question Answer Forum", style:appBarTitleStyle ),
          ),
          floatingActionButton:sharedObjectsGlobal.userSignIn? askCommunityButton():Container(),
          body:  SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: questionList.length,
                itemBuilder: (context,index){
                  Question question = questionList[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        margin: EdgeInsets.only(top:5,bottom: 5,left: 5,right: 5),
                        decoration: BoxDecoration(
                          color: sharedObjectsGlobal.offWhite,
                          boxShadow : [BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0,3),
                              blurRadius: 4
                          )],
                        ),
                        child: Column(children: [
                          question.questionImageLinks.length==0? Container():  SingleQuestionHeader(imgList: question.questionImageLinks,),
                          Container(
                            child: SingleQuestionMiddle(question: question,isPostView: false,),
                          )

                        ],)),
                  );
                },
              )
          ),

        ),
      ],
    );
  }
}