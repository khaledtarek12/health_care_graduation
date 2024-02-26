import 'package:flutter/material.dart';
import 'package:health_care/Featuers/const.dart';


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
    return Row(
      children: [
        const Text(
          'Repeat every',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
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
                      ? Colors.blue.withOpacity(0.5)
                      : kPrimaryColor.withOpacity(0.5),
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
                      color: selectedInterval == repeatInterval[index] ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(width: 10),
        const Text(
          'hours',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
