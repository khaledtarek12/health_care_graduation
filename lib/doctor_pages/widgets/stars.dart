import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        const Text("How was your experience with Dr.Anya",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                color: Color(0xFF3C365F),
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        RatingBar(
            initialRating: 1,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            direction: Axis.horizontal,
            ratingWidget: RatingWidget(
                full: image("assets/images/empty.png"),
                half: image("assets/images/full.png"),
                empty: image("assets/images/full.png")),
            onRatingUpdate: (rating) => debugPrint(rating.toString())),
      ],
    );
  }

  Widget image(String asset) {
    return Image.asset(
      asset,
      width: 25,
      height: 25,
    );
  }
}
