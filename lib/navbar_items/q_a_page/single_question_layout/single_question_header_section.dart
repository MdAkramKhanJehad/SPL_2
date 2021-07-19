// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spl_two_agri_pro/main.dart';
import 'package:spl_two_agri_pro/models/question.dart';
class SingleQuestionHeader extends StatefulWidget {
  final List<String> imgList;
  SingleQuestionHeader({required this.imgList});
  @override
  _SingleQuestionHeaderState createState() => _SingleQuestionHeaderState();
}

class _SingleQuestionHeaderState extends State<SingleQuestionHeader> {
  int current =0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.linear,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                  reverse: false,

                ),

                items: widget.imgList.map((singleImg){
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: NetworkImage(singleImg.toString()),
                              fit: BoxFit.cover,
                            )
                        ),

                      );
                    },
                  );
                }).toList(),
              ),
              widget.imgList.length<=1?Container():ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.black.withOpacity(.5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: widget.imgList.map((url) {
                      int index = widget.imgList.indexOf(url);
                      return Container(
                        width: 5.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current == index
                              ?sharedObjectsGlobal.errorColor
                              : Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
