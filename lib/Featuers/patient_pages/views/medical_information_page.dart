import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Featuers/patient_pages/data/model/information_container_model.dart';
import 'package:health_care/const.dart';
import 'package:health_care/core/helper/transation.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}

class CardListData extends StatelessWidget {
  const CardListData({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InformationContainerModel> cardData = [
      InformationContainerModel(
        text: 'إرشادات أزمة انخفاض ضغط الدم',
        image: 'assets/images/flat-world-hypertension-day-illustration.png',
        color: const Color(0xff3DC2EC),
        onTap: () {
          Get.to(() => const EmergencyLowPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
      InformationContainerModel(
        text: 'التهدئة السريعه للقلب المتسارع',
        image:
            'assets/images/pills-heart-tablets-bottle-drugstore-products-health-care-antibiotics-dosage-painkillers-analgetic-sedatives-white-background-vector-isolated-concept-metaphor-illustration.png',
        color: const Color(0xff4C3BCF),
        onTap: () {
          Get.to(() => const EmergencyLowPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
      InformationContainerModel(
        text: 'إرشادات أزمة ارتفاع ضغط الدم',
        image: 'assets/images/virus-cure-concept.png',
        color: const Color(0xff4B70F5),
        onTap: () {
          Get.to(() => const EmergencyLowPage(),
              duration: kDuration, transition: Motivation.zoomTransition());
        },
      ),
    ];
    return SizedBox(
      height: 300,
      child: ListView.separated(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              CustomMedicalCrad(informationContainerModel: cardData[index]),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: cardData.length),
    );
  }
}

class CustomMedicalCrad extends StatelessWidget {
  const CustomMedicalCrad({super.key, required this.informationContainerModel});

  final InformationContainerModel informationContainerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: informationContainerModel.onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 200,
        decoration: BoxDecoration(
          color: informationContainerModel.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Image.asset(
              informationContainerModel.image,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            Text(
              informationContainerModel.text,
              maxLines: 2,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
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

class CustomContainerInfo extends StatelessWidget {
  final String description;

  const CustomContainerInfo({
    super.key,
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
        child: Text(
          description,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
