import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/cards_lists_data.dart';
import 'package:health_care/const.dart';

class MedicalInformationPage extends StatelessWidget {
  const MedicalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryVeryDarkcolor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Important Information',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'نصائح الاسعافات الاوليه',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                SizedBox(height: 15),
                CardListData(),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'معدل نبضات القلب',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                SizedBox(height: 15),
                CardListData2(),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
