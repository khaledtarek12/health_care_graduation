import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/emergancy_info_wigdet.dart';
import 'package:health_care/const.dart';

class MissUnderstanding extends StatelessWidget {
  const MissUnderstanding({super.key});

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
          'سوء فهم ضغط الدم',
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
                    "يخنلف معدل ضربات القلب علي مدار اليوم, ذلك لأن بعض العوامل يمكن ان تلعب دوراً في التأثير بشكل مباشر علي كعدل ضربات القلب اذا قرات ستعرف عنها"),
            SizedBox(height: 20),
            EmergencyInfoWidget(
              number: "1.",
              title: "",
              description:
                  ''' لا تقلق إذا كنت تعاني من انخفاض ضغط الدم. في العديد من الحالات، يمكن للتغييرات البسيطة في نمط الحياة أن تساعد في التعامل مع المشكلة. ومع ذلك، إذا كنت تشعر بالدوار المفاجئ بعد الوقوف أو تعاني من الإغماءات المتكررة أو تعاني من أعراض أخرى مزعجة، فقد تحتاج إلى استشارة طبيب مختص. قد يكون انخفاض ضغط الدم في هذه الحالات مهددًا للحياة إذا لم يتم علاجه على الفور.''',
            ),
            EmergencyInfoWidget(
              number: "2.",
              title: "",
              description:
                  ''' لا يعني عدم ظهور أعراض أنك لا تعاني من ارتفاع ضغط الدم. في الواقع، يُعرف ارتفاع ضغط الدم في بعض الأحيان بأنه "القاتل الصامت" لأنه قد لا يكون لديك أعراض واضحة. إذا لم يتم التحكم في ارتفاع ضغط الدم، فقد يؤدي ذلك إلى تلف في القلب والأوعية الدموية والأعضاء الأخرى ويزيد من خطر الإصابة بالأمراض المرتبطة بارتفاع ضغط الدم.''',
            ),
            EmergencyInfoWidget(
              number: "3.",
              title: "",
              description:
                  '''يمكن علاج ارتفاع ضغط الدم، خاصة إذا كان ثانويًا أي بسبب سبب واضح مثل حالة صحية أخرى. في حالة الارتفاع الأساسي، لا يمكن علاجه بشكل كامل، ولكن يمكن التحكم فيه والسيطرة عليه من خلال الأدوية''',
            ),
          ],
        ),
      ),
    );
  }
}
