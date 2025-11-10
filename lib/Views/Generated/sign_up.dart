import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 756,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFFCFB991)),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 387,
                child: Container(
                  width: 362,
                  height: 48,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 362,
                          height: 48,
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
                left: 16,
                top: 487,
                child: Container(
                  width: 362,
                  height: 48,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 362,
                          height: 48,
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
                left: 16,
                top: 288,
                child: Container(
                  width: 362,
                  height: 48,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 362,
                          height: 48,
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
                left: 137,
                top: 61,
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF81CBF3),
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.62,
                    letterSpacing: 0.10,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color(0xFF000000).withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 136,
                top: 137,
                child: Container(
                  width: 122,
                  height: 122,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: Image.asset(
                        'assets/images/blank_profile_pic.png',
                      ).image,
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 302,
                child: SizedBox(
                  width: 112,
                  child: Text(
                    'Name:',
                    style: TextStyle(
                      color: const Color(0xFF81CBF3),
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
                left: 35,
                top: 401,
                child: SizedBox(
                  width: 112,
                  child: Text(
                    'Email:',
                    style: TextStyle(
                      color: const Color(0xFF81CBF3),
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
                left: 35,
                top: 501,
                child: SizedBox(
                  width: 112,
                  child: Text(
                    'Major:',
                    style: TextStyle(
                      color: const Color(0xFF81CBF3),
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.62,
                      letterSpacing: 0.10,
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
