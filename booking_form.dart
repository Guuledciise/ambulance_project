// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, library_private_types_in_public_api

import 'package:dalbo_ambulance/screens/onboding/components/payments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../screens/onboding/components/model/veiwambalance.dart';


// ignore: must_be_immutable
class FormBooking extends StatefulWidget {

    // golobal varaubel using passing argument in table home
    VeiwAmlace  list;
    final int index ;
    // ignore: use_key_in_widget_constructors
    FormBooking({required this.list, required this.index});

//  final Ambulance ambulance;

//   const FormBooking({required this.ambulance});

  @override
  _FormBookingState createState() => _FormBookingState();
}

class _FormBookingState extends State<FormBooking> {
  bool visible = false;

  final pdescriptController = TextEditingController();
  final anumberController = TextEditingController();
  final saddressController = TextEditingController();
  final daddressController = TextEditingController();
  final achargeController = TextEditingController();
  final id = TextEditingController();

  

Future<void> insertBooking() async {
  var url = Uri.parse('http://192.168.185.117/amb/Patients/booking.php');

  final pdescript = pdescriptController.text;
  final anumber = anumberController.text;
  final saddress = saddressController.text;
  final daddress = daddressController.text;
  final acharge = achargeController.text;
  //achargeController.clear();
  
pdescriptController.clear();
//anumberController.clear();
saddressController.clear();
daddressController.clear();

  if (pdescript.isEmpty ||
      anumber.isEmpty ||
      saddress.isEmpty ||
      daddress.isEmpty ||
      acharge.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('All fields are required.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return;
  }

  var data = {
    'patientDescript': pdescript,
    'LicenseNo': anumber,
    'sourceAddress': saddress,
    'destinationAddress': daddress,
    'ambulanceCharge': acharge,
  };

  var response = await http.post(url, body: json.encode(data));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    if (result['error'] != null) {
      debugPrint('Error: ${result['error']}');
    } else if (result['message'] != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text(result['message']),
            actions: <Widget>[
              TextButton(
                child: Text('Go'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                   MaterialPageRoute(
                    builder: (context) => Payments()));
                },
              ),
            ],
            
          );
        },
      );
    }
  } else {
    debugPrint('Error: ${response.reasonPhrase}');
  }
}




@override
void initState() {
  super.initState();
  
  // ignore: unnecessary_null_comparison
  if (widget.index != null) {
    // Check if the values are not null before assigning them
    if (widget.list.licen != null) {
      anumberController.text = widget.list.licen;
    }
    if (widget.list.ambulanceCharge != null) {
      achargeController.text = widget.list.ambulanceCharge;
    }
  }
}




 bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Here"),
        elevation: 0,
        backgroundColor: const Color(0xffDB1E3D),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 200,
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [const Color(0xff6B1321), const Color(0xffDB1E3D)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Welcome to',
                        style: GoogleFonts.nunito(
                          fontSize: 22.0,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        children: [
                          TextSpan(
                            text: ' Booking Ambulance',
                            style: GoogleFonts.nunito(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Reliable and reliable service.',
                      style: GoogleFonts.nunito(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 180, bottom: 20),
                  child: Center(
                    child: Container(
                      height: 630,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 50),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 239, 215, 215),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE),
                                )
                              ],
                            ),
                            child: TextField(
                              controller: pdescriptController,
                              cursorColor: const Color.fromARGB(255, 250, 249, 248),
                              decoration: const InputDecoration(
                                hintText: "Patient Description",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 30),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 239, 215, 215),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: anumberController,
                              cursorColor: const Color.fromARGB(255, 250, 249, 248),
                              decoration: const InputDecoration(
                                hintText: "Ambulance Number",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 30),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 239, 215, 215),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: saddressController,
                              cursorColor: const Color.fromARGB(255, 250, 249, 248),
                              decoration: const InputDecoration(
                                hintText: "Source Address",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 30),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 239, 215, 215),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: daddressController,
                              cursorColor: const Color.fromARGB(255, 250, 249, 248),
                              decoration: const InputDecoration(
                                hintText: "Destination Address",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 30),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 239, 215, 215),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: achargeController,
                              cursorColor: const Color.fromARGB(255, 250, 249, 248),
                              decoration: const InputDecoration(
                                hintText: "Ambulance Charge",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),

                          
                          GestureDetector(
                            onTap: (){
                              insertBooking();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 60),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20),
                              alignment: Alignment.center,
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff390810),
                                    Color(0xffDB1E3D)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 50,
                                    color: Color(0xffEEEEEE),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "Book Now",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
