import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Mainrepo extends StatelessWidget {
  Mainrepo({
    required this.date,
    required this.heading,
    Key? key,
  }) : super(key: key);

  String heading, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.0,
      padding: EdgeInsets.only(top: 20.0, left: 20),
      height: 130.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Color(0xff352c56).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff352c56),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6b649e),
                ),
              ),
              // SizedBox(height: 110.0),
              IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.file_download_outlined,
                    color: Color(0xff352c56),
                  ))
            ],
          ),
          LinearPercentIndicator(
            width: 250,
            lineHeight: 18.0,
            animation: true,
            animationDuration: 5000,
            percent: 0.91,
            barRadius: Radius.circular(10),
            backgroundColor: Color(0xfff3edf9),
            progressColor: Color(0xff8440fa),
            center: Text(
              'Risk Factor   90%',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
