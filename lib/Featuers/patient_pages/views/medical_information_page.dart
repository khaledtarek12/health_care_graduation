import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

class MedicalInformationPage extends StatelessWidget {
  const MedicalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Important Information',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            const Text(
              'نصائح الاسعافات الاوليه',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmergencyLowPage()),
                );
              },
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2B65),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        Image.asset(
                          'assets/images/flat-world-hypertension-day-illustration.png',
                          width: 180,
                          height: 180,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'إرشادات أزمة انخفاض ضغط الدم',
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyLowPage extends StatelessWidget {
  const EmergencyLowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryVeryDarkcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white))
        ],
        title: const Text(
          'إرشادات أزمة انخفاض ضغط الدم',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            EmergencyInfoWidget(
              number: "1.",
              title: "الاستلقاء",
              description:
                  "عندما تعاني من أي من أعراض انخفاض ضغط الدم، حاول الاستلقاء أو الجلوس على سطح مستوٍ بأمان وعلى الفور. يمكن أن يؤدي الاستمرار في الوقوف إلى تفاقم انخفاض ضغط الدم الموضعي. يفيد الاستلقاء أو الجلوس في تطبيع ضغط الدم.",
            ),
            // Add more EmergencyInfoWidget instances as needed
          ],
        ),
      ),
    );
  }
}

class EmergencyInfoWidget extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const EmergencyInfoWidget({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff004763), // Background color
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: 5,
                  height: 30,
                  color: Colors.red,
                  margin: const EdgeInsets.only(right: 10),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          text: '$number ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 23,
                          ),
                          children: [
                            TextSpan(
                              text: title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 19),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
