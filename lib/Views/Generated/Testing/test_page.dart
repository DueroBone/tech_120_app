import 'package:flutter/material.dart'; // DO NOT DELETE, delete/replace everything below from Figma

class Iphone161 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 856,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 48,
                top: 50,
                child: Container(
                  width: 203,
                  height: 475,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Container(
                        width: 183,
                        height: 145,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 183,
                                height: 145,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 46,
                              top: 54,
                              child: Text(
                                'Hello\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 183,
                        height: 145,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 183,
                                height: 145,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 46,
                              top: 54,
                              child: Text(
                                'Hola\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 183,
                        height: 145,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 183,
                                height: 145,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 46,
                              top: 54,
                              child: Text(
                                'Hola\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 601,
                child: Container(
                  width: 129,
                  height: 129,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 571,
                child: Container(
                  width: 141,
                  height: 59,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: OvalBorder(),
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
