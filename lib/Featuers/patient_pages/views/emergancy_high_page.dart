import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/emergancy_info_wigdet.dart';
import 'package:health_care/const.dart';

class EmergancyHighPage extends StatelessWidget {
  const EmergancyHighPage({super.key});

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
          'إرشادات أزمة ارتفاع ضغط الدم',
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
            CustomContainerInfo(
                description:
                    ''' عادة لا ترتفع ضغط الدم إذا تم التحكم فيه حينا ، ومع ذلك  قد تكون هناك حالة ان يرتفع فيها ضغط الدم بشكل غير متوقع يصل ضغط الدم الانقباضي إلى 180 ، / أو الانبساطي يصل إلى 120 ملم زئبقي والرعاية الطارئة مطلوبة ، بعد الاتصال بالخدمة الطبية الفورية أو اثناء انتظارك لسيارة الاسعاف ،  ماذا يمكن ان تكون الاسعافات الأولية لا تقلق لقد أعددنا لك كل ذلك'''),
            SizedBox(height: 20),
            EmergencyInfoWidget(
              number: "1.",
              title: "تهدئة نفسك من فوائد خفض ضغط الدم",
              description:
                  "تهدئة النفس والتقليل من التوتر والضغط النفسي يمكن أن يسهم بشكل كبير في خفض ضغط الدم. عندما يكون الشخص متوترًا أو مضغوطًا، يفرز جسمه هرمونات مثل الأدرينالين والكورتيزول، التي تتسبب في ارتفاع ضغط الدم عن طريق زيادة سرعة ضربات القلب وتضييق الأوعية الدموية. لذا، من فوائد تهدئة النفس وخفض التوتر\n  خفض ضغط الدم:   تقنيات الاسترخاء مثل التنفس العميق، والتأمل، واليوغا يمكن أن تساعد في خفض ضغط الدم عن طريق تهدئة الجهاز العصبي وتقليل إفراز هرمونات التوتر. \n تحسين صحة القلب:   تقليل التوتر يساهم في تقليل الضغط على القلب، مما يقلل من خطر الإصابة بأمراض القلب والأوعية الدموية.",
            ),
            EmergencyInfoWidget(
              number: "2.",
              title: "تناول دواء ضغط الدم ",
              description:
                  '''تناول الأدوية الخاصة بضغط الدم هو جزء مهم من إدارة ارتفاع ضغط الدم، وهي تُستخدم لخفض ضغط الدم إلى المستويات الطبيعية ولتقليل مخاطر الإصابة بمضاعفات صحية خطيرة مثل السكتات الدماغية والنوبات القلبية. الأدوية المضادة لارتفاع ضغط الدم تشمل عدة أنواع، وكل نوع يعمل بآلية مختلفة. من المهم أن يتبع المريض تعليمات الطبيب عند تناول هذه الأدوية لضمان الفعالية والأمان''',
            ),
            EmergencyInfoWidget(
              number: "3.",
              title: "رشفه شاي من كوب الكركاديه",
              description:
                  '''الكركديه هو مشروب طبيعي مشهور بفوائده الصحية العديدة، ومن بينها تأثيره الإيجابي على ضغط الدم. إليك بعض الفوائد التي قد تحصل عليها من تناول كوب من شاي الكركديه: \n خفض ضغط الدم: الدراسات تشير إلى أن الكركديه يمكن أن يساعد في خفض ضغط الدم، خاصة لدى الأشخاص الذين يعانون من ارتفاع ضغط الدم. \n غني بمضادات الأكسدة: الكركديه يحتوي على مضادات الأكسدة التي تساعد في مكافحة الجذور الحرة وتقليل الالتهابات في الجسم. ''',
            ),
          ],
        ),
      ),
    );
  }
}
