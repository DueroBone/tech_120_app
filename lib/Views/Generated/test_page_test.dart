import 'package:flutter/material.dart';

class Iphone161 extends StatelessWidget {
  const Iphone161({Key? key}) : super(key: key);

  static const double _baseWidth = 393;
  static const double _baseHeight = 756;

  @override
  Widget build(BuildContext context) {
    // The outer Column is retained; wrap the artboard in a Flexible + SingleChildScrollView
    // so the page can scroll when the artboard is taller than available space.
    return Column(
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: AspectRatio(
              aspectRatio: _baseWidth / _baseHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;
                  final scale = width / _baseWidth;

                  // helper to scale text sizes
                  double s(double value) => value * scale;

                  return Container(
                    width: width,
                    height: height,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Stack(
                      children: [
                        // Left column group (was Positioned left:48, top:50, width:203, height:475)
                        Positioned(
                          left: 48 * scale,
                          top: 50 * scale,
                          width: 203 * scale,
                          height: 475 * scale,
                          child: Padding(
                            padding: EdgeInsets.all(10 * scale),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildCard(s, scale),
                                SizedBox(height: 10 * scale),
                                _buildCard(s, scale),
                                SizedBox(height: 10 * scale),
                                _buildCard(s, scale),
                              ],
                            ),
                          ),
                        ),

                        // Circular shape (was left:39, top:601, size:129)
                        Positioned(
                          left: 39 * scale,
                          top: 601 * scale,
                          width: 129 * scale,
                          height: 129 * scale,
                          child: Container(
                            decoration: const ShapeDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),

                        // Oval pill (was left:214, top:571, width:141, height:59)
                        Positioned(
                          left: 214 * scale,
                          top: 571 * scale,
                          width: 141 * scale,
                          height: 59 * scale,
                          child: Container(
                            decoration: const ShapeDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // small helper to create the repeated card used three times
  Widget _buildCard(double Function(double) s, double scale) {
    return SizedBox(
      width: 183 * scale,
      height: 145 * scale,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19 * scale),
                ),
              ),
            ),
          ),
          Positioned(
            left: 46 * scale,
            top: 54 * scale,
            child: Text(
              'Hola',
              style: TextStyle(
                color: Colors.black,
                fontSize: s(12),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
