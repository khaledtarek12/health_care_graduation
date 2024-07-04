import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/views/widget/emergancy_info_wigdet.dart';
import 'package:health_care/const.dart';

class WhatHeartRatePage extends StatelessWidget {
  const WhatHeartRatePage({super.key});
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
          'ماهو معدل نبضات القلب',
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
                    ''''معدل ضربات القلب' أو النبض، هو عدد ضربات قلبك لكل وحدة زمنية، وعادة ما تكون دقيقة. في كل مرة ينبض فيها القلب، يتم ضخ الدم من القلب إلى الجسم لتوزيع الجسم بالأكسجين نظراً لأن الحاجة إلى الأكسجين تتغير عندما يكون الناس في حالات مختلفة. مثل الراحة وممارسة الرياضة، وما إلى ذلك، فإن عبء عمل القلب لتوزيع الدم يتغير يوجد مؤثرين مختلفين لمعدل ضربات القلب: معدل ضربات القلب أثناء الراحة ومعدل ضربات القلب المستهدف. أحدهما لقياس مدى ذاتك فلبك عندما تكون في حالة راحة. يتم استخدام الآخر لمعرفة معدل ضربات القلب المستهدف المثالي أثناء، التمرين.'''),
            SizedBox(height: 20),
            EmergencyInfoWidget(
              number: "1.",
              title: " نطقات معدل ضربات القلب أثناء الراحة ",
              description:
                  '''الأطفال من سنة إلى سنتين): 80 إلى 130 نبضة في الدقيقة\n
الأطفال من 3 إلى 4 سنوات): 80 إلى 120 نبضة في الدقيقة\n
الأطفال من 5 إلى 6 سنوات): 75 إلى 115 نبضة في الدقيقة\n
الأطفال من 7 إلى 9 سنوات): 70 إلى 110 نبضة في الدقيقة\n
الأطفال من 10 إلى 15 سنة): 60 إلى 100 نبضة في الدقيقة\n
البالغين (فوق 15 سنة): 60 إلى 100 نبضة في الدقيقة\n''',
            ),
            EmergencyInfoWidget(
              number: "2.",
              title: "نطاقات شده التمرين ",
              description:
                  ''' أثناء التمرين ، يمكنك رؤية شدة تدريبك عن طريق معدل ضربات القلب المستهدف.
فيما يلي نطقات معدل ضربات القلب المستهدفة وفقًا لذلك:
\n
 : HRmax لإما: %60 من\n
 HRmax التدريب المستهدف: %60 - %79 من\n
 HRmax التدريب كفاءة عالية: %80 - %89 من\n
 %90 من أقصى معدل ضربات القلب: خطرف\n
\n
 • يرجى ملاحظة أنه لا يمكن استخدام تطبيقنا كبديل لخدمات الرعاية الصحية الاحترافية. 
 • إذا كان لديك تسارع مستمر في ضربات القلب أو أي مشاكل قلبية ، فمن الضروري استشارة طبيبك في الوقت المناسب. \n''',
            ),
          ],
        ),
      ),
    );
  }
}
