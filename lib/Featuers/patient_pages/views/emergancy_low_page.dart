import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/emergancy_info_wigdet.dart';
import 'package:health_care/const.dart';

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
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white , fontFamily: 'Cairo'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            CustomContainerInfo(
                description:
                    '''لا توجد نقطة محددة يصبح فيها ضغط الدم منخفضاً جداً. ومع ذلك، إذا كانت الأعراض الشديدة ناجمة عن انخفاض ضغط الدم، فهذا يشير إلى حالة طارئة لخفض ضغط الدم. يجب أن تكون الخطوة الأولى هي الاتصال بطبيبك للحصول على علاج طبي فوري واتخاذ مراجعة دقيقة لأدويتك. وكان ماذا يمكنك أن تفعل؟ تعلم النصائح أدناه وقد تكون جاهزاً بعد الآن.'''),
            SizedBox(height: 20),
            EmergencyInfoWidget(
              number: "1.",
              title: "الاستلقاء",
              description:
                  "عندما تعاني من أي من أعراض انخفاض ضغط الدم، حاول الاستلقاء أو الجلوس على سطح مستوٍ بأمان وعلى الفور. يمكن أن يؤدي الاستمرار في الوقوف إلى تفاقم انخفاض ضغط الدم الموضعي. يفيد الاستلقاء أو الجلوس في تطبيع ضغط الدم.",
            ),
            EmergencyInfoWidget(
              number: "2.",
              title: "تناول الملح الكافي ",
              description:
                  '''جرب تناول المزيد من الأطعمة المالحة أو بلعق قليل من الملح للسماح للصوديوم برفع ضغط الدم. يمكنك أيضاً شرب المشروبات الرياضية أو تناول أملاح الإماهة الفموية (ORS) التي يمكن أن تعيد ترطيبك وتوفر الملح بالإضافة إلى الأملاح الأخرى لتحسين ضغط الدم.
ومع ذلك، لا تتناول أملاح الإماهة الفموية إذا كنت مريضاً بالسكري وتأكد من أنك لا تتناول الكثير.''',
            ),
            EmergencyInfoWidget(
              number: "3.",
              title: "ابقي رطباً",
              description:
                  '''الجفاف هو أحد الأسباب الشائعة لانخفاض ضغط الدم. وبالتالي، فإن شرب المزيد من السوائل، وخاصةً الماء، والمشروبات الرياضية، لا يمكن أن يشمل ذلك فقدان من السوائل بشدة. قم بذلك، يمكن أن يساعد الجفاف. مع ذلك، يمكنك إضافة كمية صغيرة من الملح إذا.''',
            ),
          ],
        ),
      ),
    );
  }
}