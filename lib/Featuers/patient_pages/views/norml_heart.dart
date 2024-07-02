import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/emergancy_info_wigdet.dart';
import 'package:health_care/const.dart';

class NormlHeartPage extends StatelessWidget {
  const NormlHeartPage({super.key});
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
          'التهدئه السريعه للقلب المتسارع',
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
                    '''في بعض الأحيان يرتفع معدل ضربات القلب وقد يرتفع معدل ضربات القلب. لإرجاء قلبك وخفض النبض المرتفع مؤقتًا في الوقت الحالي، جرب هذه الطرق أدناه'''),
            SizedBox(height: 20),
            EmergencyInfoWidget(
              number: "1.",
              title: "تمارين التنفس العميق",
              description:
                  '''عادة ما تحدث التغيرات المفاجئة في معدل ضربات القلب بسبب الاضطراب العاطفي أو القلق لتهدئ نفسك، تحتاج إلى ممارسة التنفس العميق أو التأمل. علّق على ذلك، ووفقًا للدكتور جون إيفيراردس، الذي يعمل مع معهد وولف في جامعة ييل، هناك تمرين سريع للتنفس لتهدئة قلبك، وهو ما يسمى مناورة vagal. \n يمكنك إغلاق فمك وقم بإيقاف الضغط على صدرك، كما لو كنت تتعرض لنفخ قوي. كرر العملية لمدة 5 ثوانٍ. أو، يمكنك أيضًا تكرار ذلك عدة مرات لتنشيط العصب المبهم لخفض معدل ضربات القلب.''',
            ),
            EmergencyInfoWidget(
              number: "2.",
              title: "ابق بعيدًا عن الحرارة",
              description:
                  '''كلما زادت درجة الحرارة، زادت سرعة خفقات قلبك. وتالياً ستكون الحاجة إلى البقاء في مكان بارد ومريح للحفاظ على معدل ضربات القلب الطبيعي.''',
            ),
            EmergencyInfoWidget(
              number: "3.",
              title: "ارتفاع ببطء",
              description:
                  '''  يمكن أن يؤدي تغيير وضعيتك من الجلوس إلى الوقوف بسرعة كبيرة إلى رفع معدل ضربات القلب. احذر من ذلك وحاول أن تنهض ببطء.''',
            ),
            EmergencyInfoWidget(
              number: "4.",
              title: "الغمر في الماء البارد",
              description:
                  ''' يمكنك غمر وجهك أو أجزاء أخرى من الجسم في الماء البارد. تخفض درجة حرارة الجسم مما يؤدي إلى انخفاض خفقان الدم المحيط وانخفاض معدل ضربات القلب.''',
            ),
          ],
        ),
      ),
    );
  }
}
