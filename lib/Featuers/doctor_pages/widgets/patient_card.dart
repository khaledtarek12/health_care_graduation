import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/Featuers/doctor_pages/views/patient_location.dart';
import 'package:health_care/Featuers/doctor_pages/widgets/pdf_view.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/Featuers/patient_pages/views/heart_beat_view.dart';
import 'package:health_care/Featuers/patient_pages/views/history_of_patient_view.dart';
import 'package:health_care/const.dart';
import 'package:health_care/Featuers/login_and_signup/Screens/chat_page.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:health_care/core/helper/transation.dart';
import 'package:health_care/core/utils/styles.dart';
import 'package:path_provider/path_provider.dart';

class Patientcard extends StatelessWidget {
  const Patientcard({super.key, required this.patientModel});

  final PatientModel patientModel;

  Future<void> openPatientHistory(String email, BuildContext context) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('patientHistory')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String fileUrl = snapshot.docs.first['fileUrl'];
        String fileName = snapshot.docs.first['fileName'];
        await downloadAndOpenPdf(fileUrl, fileName);
      } else {
        throw 'No file found for this patient';
      }
    } catch (e) {
      showErrorDialog(
        // ignore: use_build_context_synchronously
        context: context, message: '$e',
        btnOkOnPress: () {},
      );
    }
  }

  Future<void> downloadAndOpenPdf(String fileUrl, String fileName) async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDocDir.path}/$fileName';

      if (await File(filePath).exists()) {
        // File already exists locally, open it
        openPdf(filePath);
      } else {
        // File doesn't exist locally, download it first
        await downloadPdf(fileUrl, filePath);
      }
    } catch (e) {
      log('Error downloading and opening PDF: $e');
    }
  }

  Future<void> downloadPdf(String fileUrl, String filePath) async {
    try {
      log('Downloading PDF from $fileUrl');
      await Dio().download(fileUrl, filePath);
      log('PDF downloaded to $filePath');
      openPdf(filePath);
    } catch (e) {
      log('Error downloading PDF: $e');
    }
  }

  void openPdf(String filePath) {
    Get.to(() => PdfViewerPage(filePath: filePath));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
        gradient: LinearGradient(
          colors: [kPrimaryColor, kPrimaryColor.withOpacity(.6)],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/healthcare.png',
                fit: BoxFit.fill,
                width: 130,
                height: 130,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${patientModel.firstName} ${patientModel.lastName}',
                    style: style15.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    textDirection: TextDirection.rtl,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildIcon(
                            icon: FontAwesomeIcons.facebookMessenger,
                            size: 35,
                            onPressed: () {
                              Get.to(
                                () => ChatPage(
                                  senderEmail: patientModel.doctorEmail!,
                                  recieverEmail: patientModel.patientEmail,
                                  doctorEmail: patientModel.doctorEmail!,
                                  patientEmail: patientModel.patientEmail,
                                ),
                                transition: Motivation.bootmUpTransition(),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          _buildIcon(
                            icon: Icons.history_edu_rounded,
                            size: 35,
                            onPressed: () {
                              Get.to(
                                () => const HistoryOfPatientPage(),
                                transition: Motivation.zoomTransition(),
                                arguments: {
                                  'doctorEmail': patientModel.doctorEmail,
                                  'firstName': patientModel.firstName,
                                  'lastName': patientModel.lastName,
                                  // Add more arguments as needed
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          _buildIcon(
                            icon: Icons.bar_chart_rounded,
                            size: 35,
                            onPressed: () {
                              Get.to(
                                () => const HeartBeatView(),
                                transition: Motivation.zoomTransition(),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          _buildIcon(
                            icon: FontAwesomeIcons.locationDot,
                            size: 35,
                            onPressed: () {
                              Get.to(
                                () => PatientLocationPage(
                                  patientEmail: patientModel.patientEmail,
                                ),
                                arguments: patientModel,
                                transition: Motivation.bootmUpTransition(),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          _buildIcon(
                            icon: Icons.file_open,
                            size: 35,
                            onPressed: () {
                              openPatientHistory(
                                  patientModel.patientEmail, context);
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon({
    required IconData icon,
    required double size,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(16)),
      child: IconButton(
        icon: Icon(icon, size: size, color: kprimaryDarkcolor),
        onPressed: onPressed,
      ),
    );
  }
}
