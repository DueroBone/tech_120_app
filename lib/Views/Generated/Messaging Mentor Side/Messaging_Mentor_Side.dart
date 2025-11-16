import 'package:flutter/material.dart';
class MentorMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 756,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [const Color(0xFF253067), const Color(0xFF8A4EBC)],
            ),
            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: -16,
                top: 129,
                child: Container(
                  width: 429,
                  height: 43,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 429,
                          height: 43,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 136,
                child: Container(
                  width: 343,
                  height: 30,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 343,
                          height: 30,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFDF4F4),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 99,
                top: 81,
                child: Text(
                  'Messages',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF81CBF3),
                    fontSize: 40,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.50,
                    letterSpacing: 0.10,
                    shadows: [Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0xFF000000).withOpacity(0.25))],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 293,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/75x75"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 396,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/75x75"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 499,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/75x75"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 596,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/75x75"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 196,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/75x75"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 104,
                top: 209,
                child: Container(
                  width: 256,
                  height: 49,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 256,
                          height: 49,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 215,
                child: SizedBox(
                  width: 163,
                  height: 37,
                  child: Text(
                    'Student 1',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.62,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 104,
                top: 410,
                child: Container(
                  width: 256,
                  height: 49,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 256,
                          height: 49,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 416,
                child: SizedBox(
                  width: 163,
                  height: 37,
                  child: Text(
                    'Student 3',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.62,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 108,
                top: 512,
                child: Container(
                  width: 256,
                  height: 49,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 256,
                          height: 49,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 518,
                child: SizedBox(
                  width: 163,
                  height: 37,
                  child: Text(
                    'Student 4',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.62,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 108,
                top: 609,
                child: Container(
                  width: 256,
                  height: 49,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 256,
                          height: 49,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 615,
                child: SizedBox(
                  width: 163,
                  height: 37,
                  child: Text(
                    'Student 5',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.62,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 102,
                top: 306,
                child: Container(
                  width: 256,
                  height: 49,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 256,
                          height: 49,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 125,
                top: 312,
                child: SizedBox(
                  width: 163,
                  height: 37,
                  child: Text(
                    'Student 2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.62,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 3,
                top: 681,
                child: Container(
                  width: 393,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF81CBF3),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 122,
                child: Container(
                  width: 393,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF81CBF3),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1,
                top: 184,
                child: Container(
                  width: 393,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF81CBF3),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -22,
                top: 138,
                child: Container(
                  width: 90,
                  height: 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/90x24"),
                      fit: BoxFit.contain,
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