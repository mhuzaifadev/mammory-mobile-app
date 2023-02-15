import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kgooglePlex = CameraPosition(
      target: LatLng(24.902888919915164, 67.21069984626078), zoom: 10);
  //47.574959034609556, 127.42845044528966
  List<Marker> _marker = [];
  final List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.91294769, 67.09308809),
        infoWindow: InfoWindow(title: 'Cancer Foundation hospital',
          snippet: '(02)134991071'
        )),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(24.87321498, 67.07340402),
        infoWindow: InfoWindow(title: 'Bait-ul-Sukoon Cancer Hospital', snippet: '(021) 34553834')),
         Marker(
        markerId: MarkerId('3'),
        position: LatLng(24.85307906,  67.04411956),
        infoWindow: InfoWindow(title: 'Jinnah Hospital Karachi',snippet: '021 99201300')),
         Marker(
        markerId: MarkerId('4'),
        position: LatLng(24.92109422,  67.0296143),
        infoWindow: InfoWindow(title: ' Abbassi Shaheed Hospital',snippet: '021 9260400')),
         Marker(
        markerId: MarkerId('5'),
        position: LatLng(24.89248713,  67.0748962),
        infoWindow: InfoWindow(title: ' Aga Khan University Hospital',snippet: '021 111 911 911')),
          Marker(
        markerId: MarkerId('6'),
        position: LatLng(24.92373096,  67.04754945),
        infoWindow: InfoWindow(title: '  Dr. Ziauddin Cancer Hospital',snippet: '021 36648237')),
         Marker(
        markerId: MarkerId('7'),
        position: LatLng(24.85907683,  67.01012382),
        infoWindow: InfoWindow(title: '  Dr. Ruth K.M. Pfau, Civil Hospital Karachi',snippet: '021 99215740')),
         Marker(
        markerId: MarkerId('8'),
        position: LatLng(24.9179905,  67.03219347),
        infoWindow: InfoWindow(title: '  A.O. Hospital',snippet: '021 36685560')),
          Marker(
        markerId: MarkerId('9'),
        position: LatLng(24.85292587, 67.01005865),
        infoWindow: InfoWindow(title: '  Burhani Hospital', snippet: '021 99201300')),
  
     Marker(
        markerId: MarkerId('10'),
        position: LatLng(24.94720397, 67.144677),
        infoWindow: InfoWindow(title: '  Kiran Hospital',snippet: '(021)99261601')),
   Marker(
        markerId: MarkerId('11'),
        position: LatLng(24.92372914, 67.09081176),
        infoWindow: InfoWindow(title: '  Pak Onco Care (Cancer Treatment Center)',snippet: '(021)34980057')),
         Marker(
        markerId: MarkerId('12'),
        position: LatLng(24.83700879, 67.05024687),
        infoWindow: InfoWindow(title: '  PNS Shifa Hospital',snippet: '(021)48506777')),
         Marker(
        markerId: MarkerId('13'),
        position: LatLng(24.83478576,67.0331277),
        infoWindow: InfoWindow(title: '  Shaukat Khanum Memorial Trust',snippet: '(021)35872573')),
         Marker(
        markerId: MarkerId('14'),
        position: LatLng(24.85968565,67.01170281),
        infoWindow: InfoWindow(title: '  Oncology Ward',)),
          Marker(
        markerId: MarkerId('15'),
        position: LatLng(24.88278884,67.08223983),
        infoWindow: InfoWindow(title: ' Tahir Medical Center',snippet: '(021)34380163')),
         Marker(
        markerId: MarkerId('16'),
        position: LatLng(24.86729051,67.02371797),
        infoWindow: InfoWindow(title: ' Anklesaria Hospital',snippet: '(021)32720371')),
          Marker(
        markerId: MarkerId('17'),
        position: LatLng(24.85476876,67.04346917),
        infoWindow: InfoWindow(title: ' Neurospinal & cancer care Institute Karachi Sindh Pakistan')),
          Marker(
        markerId: MarkerId('18'),
        position: LatLng(24.93150205,67.03854763),
        infoWindow: InfoWindow(title: 'Saifee Hospital',snippet: '(021)36789400')),
         Marker(
        markerId: MarkerId('19'),
        position: LatLng(24.88122728,67.06352577),
        infoWindow: InfoWindow(title: 'Medicare Cardiac & General Hospital',snippet: '(021)38658901')),
           Marker(
        markerId: MarkerId('20'),
        position: LatLng(24.90216676,67.08133529),
        infoWindow: InfoWindow(title: 'KARACHI MEDICAL COMPLEX Consultant Clinic',snippet: '(0)3322173522')),
         Marker(
        markerId: MarkerId('21'),
        position: LatLng(24.83329943,67.17916143),
        infoWindow: InfoWindow(title: 'National Medical center')),
        
         Marker(
        markerId: MarkerId('22'),
        position: LatLng(24.87823562,67.03413041),
        infoWindow: InfoWindow(title: 'Fatimiyah Hospital, Karachi',snippet: '(021)111012014')),
         Marker(
        markerId: MarkerId('23'),
        position: LatLng(24.86119751,67.01204601),
        infoWindow: InfoWindow(title: 'Sindh Institute of Urology and Transplantation',snippet: '(021)99215752')),
         Marker(
        markerId: MarkerId('24'),
        position: LatLng(24.93889358,67.07745957),
        infoWindow: InfoWindow(title: 'Mamji Hospital')),
         Marker(
        markerId: MarkerId('25'),
        position: LatLng(24.8347477,67.03318767),
        infoWindow: InfoWindow(title: 'Hilal e Ahmer Hospital',snippet: '(0)3332442683')),
  
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3edf9),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(310, 55),
                    backgroundColor: Color(0xff8440fa),
                    foregroundColor: Color(0xff8440fa),
                   // side: BorderSide(color: Color(0xff8440fa)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: (() {}),
                child: Text(
                  'Online Doctors (Comming Soon)',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Flexible(
              flex: 1,
              child: Text(
                'Nearby Screening Facilities',
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff352c56),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Flexible(
              flex: 8,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _kgooglePlex,
                    mapType: MapType.normal,
                    // myLocationEnabled: true,
                    markers: Set<Marker>.of(_marker),
                    //  compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        maprow(
                          title: '10km',
                        ),
                        maprow(
                          title: '30km',
                        ),
                        maprow(
                          title: '50km',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class maprow extends StatelessWidget {
  const maprow({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(90, 35),
          backgroundColor: Color(0xff8440fa),
      
          side: BorderSide(color: Color(0xff8440fa)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onPressed: (() {}),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.0,
          //fontWeight: FontWeight.w200,
          color: Colors.white,
        ),
      ),
    );
  }
}
