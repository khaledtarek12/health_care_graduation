import 'package:flutter/material.dart';
import 'package:health_care/const.dart';

class RepeatIntervalWidget extends StatelessWidget {
  final int? selectedInterval;
  final Function(int)? onIntervalSelected;

  const RepeatIntervalWidget({
    super.key,
    this.selectedInterval,
    this.onIntervalSelected,
  });

  

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const Text(
          'Choose Repeating time',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: List.generate(4, (index) {
            final repeatInterval = [6, 8, 12, 24];
            return GestureDetector(
              onTap: () {
                if (onIntervalSelected != null) {
                  onIntervalSelected!(repeatInterval[index]);
                }
              },
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedInterval == repeatInterval[index]
                      ? const Color(0xff191d2d)
                      : kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(
                        0,
                        3,
                      ), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${repeatInterval[index]}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedInterval == repeatInterval[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
