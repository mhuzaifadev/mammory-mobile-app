import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mammory_project/views/login/Report/devInfo.dart';
import 'package:mammory_project/views/login/userprofile.dart';

import 'component/reportContainer.dart';

class MainRepo extends StatefulWidget {
  const MainRepo({super.key});

  @override
  State<MainRepo> createState() => _MainRepoState();
}

var chanagefilter = 1;
var selectedtype = 0;

var plmainsel = 0;

class _MainRepoState extends State<MainRepo> {
  @override
  Widget build(BuildContext context) {
    List planmain = [
      {'id': 1, 'name': 'Mamogram'},
      {'id': 2, 'name': 'All'},
      {'id': 3, 'name': 'Ultrasound'},
    ];
    return Scaffold(
      backgroundColor: Color(0xfff3edf9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Color(0xff8440fa),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  leading: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Devinfo()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 231, 210, 235),
                      radius: 30,
                      backgroundImage:
                          ExactAssetImage('images/MammoryLogo.png'),
                    ),
                  ),
                  title: Text(
                    'Mammory',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xfff3edf9)),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Get.to(() => UserProfile());
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: ExactAssetImage('images/reg_img.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                'Reports History',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3f3754)),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var plmain in planmain)
                    InkWell(
                        onTap: (() {
                          setState(() {
                            plmainsel = plmain['id'];
                            print(plmainsel);
                            // print('Mammogram');
                            // chanagefilter = 1;
                            // selectedtype = 0;
                          });
                          plmainsel = plmain['id'];
                        }),
                        child: plmainsel == plmain['id']
                            ? Filter(
                                "${plmain['name']}",
                                1,
                                Color(0xff8440fa),
                              )
                            : Filter("${plmain['name']}", 1,
                                Color.fromARGB(255, 249, 242, 251))),
                ],
              ),
              if (plmainsel == 1) ...[
                SizedBox(
                  height: 15.0,
                ),
                Mainrepo(
                    date: '4:23 AM Jan 19, 2023',
                    heading: 'Mammogram Screening'),
              ],
              if (plmainsel == 3) ...[
                SizedBox(
                  height: 15.0,
                ),
                Mainrepo(
                    date: '8:10 PM Jan 19, 2023',
                    heading: 'Ultrasound Screening')
              ],
              if (plmainsel == 2) ...[
                SizedBox(
                  height: 15.0,
                ),
                Mainrepo(
                    date: '4:23 AM Jan 19, 2023',
                    heading: 'Mammogram Screening'),
                SizedBox(
                  height: 15.0,
                ),
                Mainrepo(
                    date: '8:10 PM Jan 19, 2023',
                    heading: 'ultrasound Screening'),
              ],
            ]),
          ),
        ),
      ),
    );
  }
}

class Filter extends StatelessWidget {
  final String? title;
  final int? state;
  final Color? col;
  Filter(this.title, this.state, this.col);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 84, 43, 196)),
          color: col,
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        title!.toUpperCase(),
        style: theme.bodyText2!.copyWith(color: Colors.black),
      ),
    );
  }
}
