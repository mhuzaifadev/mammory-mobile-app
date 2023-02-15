import 'package:flutter/material.dart';
import 'package:mammory_project/views/login/Mainrepo/mainreport.dart';

class Devinfo extends StatefulWidget {
  const Devinfo({super.key});

  @override
  State<Devinfo> createState() => _DevinfoState();
}

String selectedItem = "";

class _DevinfoState extends State<Devinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Color(0xff8440fa),
        centerTitle: true,
        title: Text(
          "R&D Team",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          Attributeinfo(context, 'M.Huzaifa Shahbaz', 'AI Engineer & Flutter Developer'),
          Attributeinfo(context, 'Zain ul Abidin', 'AI Researchers '),
          Attributeinfo(context, 'Wareesha Hafeez', ' Flutter Developer'),
          Attributeinfo(context, 'Muhammad Yousuf', 'Full Stack & Flutter Developer'),
          Attributeinfo(context, 'Usama Mafrani', ' Flutter Developer'),
          Attributeinfo(context, 'Maham Abbasi', 'Product Analyst'),
        ],
      ),
    );
  }
}

Widget Attributeinfo(context, title, subtitl) {
  return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.03,
        bottom: MediaQuery.of(context).size.height * 0.01,
        left: MediaQuery.of(context).size.height * 0.02,
        right: MediaQuery.of(context).size.height * 0.02,
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.015,
        left: MediaQuery.of(context).size.height * 0.01,
        right: MediaQuery.of(context).size.height * 0.01,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 129, 45, 144).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
// key: PageStorageKey<String>(title),

        leading: ClipOval(
          child: CircleAvatar(
            backgroundColor: Colors.yellow,
            radius: 25,
            child: Image.asset(
              'images/reg_img.png',
            ),
          ),
        ),

        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        subtitle: Text(
          subtitl,
          style: TextStyle(color: Colors.grey),
        ),
        onExpansionChanged: ((newState) {
          print(title + ' is now ' + newState.toString());
        }),

        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying o"
                " n meaningful content. Lorem ipsum may be used as a placeholder before final copy is available",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ));
}
