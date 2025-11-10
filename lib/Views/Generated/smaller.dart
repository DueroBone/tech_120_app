import 'package:flutter/material.dart';

class Smaller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,
          height: 568,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFF62E4FF)),
          child: Stack(
            children: [
              Positioned(
                left: 39,
                top: 96,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBA6A6),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 199,
                top: 111,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBA6A6),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 18.15,
                top: 265,
                child: Container(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(0.84),
                  width: 151,
                  height: 15,
                  decoration: BoxDecoration(color: const Color(0xFFFBA6A6)),
                ),
              ),
              Positioned(
                left: 97,
                top: 367,
                child: Container(
                  width: 117,
                  height: 20,
                  decoration: BoxDecoration(color: const Color(0xFFFBA6A6)),
                ),
              ),
              Positioned(
                left: 199,
                top: 368.39,
                child: Container(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-0.75),
                  width: 156,
                  height: 25,
                  decoration: BoxDecoration(color: const Color(0xFFFBA6A6)),
                ),
              ),
              Positioned(
                left: 58,
                top: 407,
                child: SizedBox(
                  width: 204,
                  height: 149,
                  child: Text(
                    'This is a block of text that is long enough to wrap around and I am still typing to see how everything reacts!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFC700FF),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
