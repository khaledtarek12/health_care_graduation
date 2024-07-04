import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/emergancy_info_wigdet.dart';
import 'package:health_care/const.dart';

class AlarentAffectPage extends StatelessWidget {
  const AlarentAffectPage({super.key});

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
          'العوامل المؤثره في معدل نبضات القلب',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          maxLines: 2,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontFamily: 'Cairo'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            CustomContainerInfo(
                description:
                    '''.يختلف معدل ضربات قلبك على مدار اليوم. ذلك لان بعض العوامل  يمكن أن تلعب دورا في التأثير بشكل مباشر على معدل ضربات القلب، إذا قرأت، فستعرف عنها'''),
            SizedBox(height: 20),
            EmergencyInfoWidget(
              number: "1.",
              title: "درجة حرارة",
              description:
                  ''' • يؤثر تغيير درجة حرارة الجو، أو درجة حرارة جسمك على معدل ضربات قلبك.
إذا كنت تعاني من الحمى: الغذاء، أو التغذية السيئة، أو التغيرات في النوم إلى غير ذلك.
بالتالي، إن تغير معدل ضربات قلبك من 6 إلى 16 نبضة في الدقيقة.
 تتفاوت الرطوبة المرتفعة أيضاً في بناء معدل ضربات القلب.
بناءً على ذلك، يمكن أن تؤدي الرطوبة المرتفعة أيضاً إلى تغيير معدل ضربات القلب''',
            ),
            EmergencyInfoWidget(
              number: "2.",
              title: "وضع الجسم",
              description:
                  '''عادة يتغير ضربات القلب في اوضاع الجسم المختلفة وذلك اذا غيرت وضع جسمك فجاة الي وضع الوفوف فسوف يرتفع ضربات قلبك في اول 15 او 20 ثانية''',
            ),
          ],
        ),
      ),
    );
  }
}
