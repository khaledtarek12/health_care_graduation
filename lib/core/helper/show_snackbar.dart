import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/core/utils/styles.dart';

void showErrorSnackBar(
    {required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
            color: Color(0xffc72c41),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Oh snap!',
                      style:
                          style15.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleNormal.copyWith(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/images/bubbles.svg",
              height: 48,
              width: 40,
              colorFilter:
                  const ColorFilter.mode(Color(0xff801336), BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          top: -13,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset("assets/images/fail.svg", height: 40),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  "assets/images/close.svg",
                  height: 16,
                ),
              )
            ],
          ),
        )
      ],
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
            color: Color(0xFF0B7141),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Well done!',
                      style:
                          style15.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleNormal.copyWith(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/images/bubbles.svg",
              height: 48,
              width: 40,
              colorFilter:
                  const ColorFilter.mode(Color(0xFF004E2F), BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          top: -13,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/fail.svg",
                height: 40,
                colorFilter:
                    const ColorFilter.mode(Color(0xFF004E2F), BlendMode.srcIn),
              ),
              Positioned(
                  top: 6,
                  child: SvgPicture.asset(
                    "assets/images/check_mark.svg",
                    height: 22,
                  ))
            ],
          ),
        )
      ],
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}

void showWarrinngSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
            color: Color(0xFFED8D2B),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warning..!',
                      style:
                          style15.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleNormal.copyWith(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/images/bubbles.svg",
              height: 48,
              width: 40,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFCD571D), BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          top: -13,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                " assets/images/fail.svg",
                height: 40,
                colorFilter:
                    const ColorFilter.mode(Color(0xFFCD571D), BlendMode.srcIn),
              ),
              Positioned(
                  top: 6,
                  child: SvgPicture.asset(
                    "assets/images/exclamation_mark.svg",
                    height: 30,
                  ))
            ],
          ),
        )
      ],
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}
