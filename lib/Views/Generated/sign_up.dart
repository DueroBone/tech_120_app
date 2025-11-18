import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _majorController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(45),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 365,
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: _majorController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter major',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0.62,
                        letterSpacing: 0.10,
                      ),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
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
                left: 16,
                top: 449,
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter email',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0.62,
                        letterSpacing: 0.10,
                      ),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
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
                left: 16,
                top: 529,
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter password',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0.62,
                        letterSpacing: 0.10,
                      ),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
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
                left: 16,
                top: 288,
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter name',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0.62,
                        letterSpacing: 0.10,
                      ),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
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
                left: 107,
                top: 81,
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF81CBF3),
                    fontSize: 48,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.42,
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
                left: 107,
                top: 81,
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF81CBF3),
                    fontSize: 48,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.42,
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
                left: 136,
                top: 137,
                child: Container(
                  width: 122,
                  height: 122,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/122x122"),
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
              // Name label removed to allow taps to reach the input field
              // Email label removed to allow taps to reach the input field
              // Password label removed to allow taps to reach the input field
              // Major label removed to allow taps to reach the input field
              Positioned(
                left: 9,
                top: 722,
                child: Container(
                  width: 375,
                  height: 34,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 121,
                        top: 21,
                        child: Container(
                          width: 134,
                          height: 5,
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 722,
                child: Container(
                  width: 375,
                  height: 34,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 121,
                        top: 21,
                        child: Container(
                          width: 134,
                          height: 5,
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 605,
                child: Container(
                  width: 207,
                  height: 90,
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
                          width: 207,
                          height: 90,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF81CBF3),
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
                left: 93,
                top: 605,
                child: Container(
                  width: 207,
                  height: 90,
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
                          width: 207,
                          height: 90,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF81CBF3),
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
                left: 132,
                top: 624,
                child: SizedBox(
                  width: 130,
                  height: 52,
                  child: Text(
                    'Sign Up!',
                    style: TextStyle(
                      color: const Color(0xFFD9D9D9),
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
                left: 132,
                top: 624,
                child: SizedBox(
                  width: 130,
                  height: 52,
                  child: Text(
                    'Sign Up!',
                    style: TextStyle(
                      color: const Color(0xFFD9D9D9),
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
