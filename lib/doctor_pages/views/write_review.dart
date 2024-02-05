import 'package:flutter/material.dart';

import '../widgets/image_review.dart';
import '../widgets/opinion.dart';
import '../widgets/stars.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffECECEC),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF3C365F),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Write a Review",
              style: TextStyle(
                  color: Color(0xFF3C365F), fontWeight: FontWeight.bold),
            ),
          ),
          body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 170, child: Imagereview()),
                  ),
                  SliverToBoxAdapter(
                    child: Stars(),
                  ),
                  SliverToBoxAdapter(child: Opinion()),
                ],
              ))),
    );
  }
}
