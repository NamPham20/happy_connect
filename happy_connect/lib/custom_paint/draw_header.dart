import 'package:flutter/material.dart';

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Góc trên bên trái
    path.lineTo(0, size.height - 80); // Cạnh trái
    path.arcToPoint(
      Offset(40, size.height-40), // Kết thúc cung tròn ở giữa cạnh dưới
      radius: const Radius.circular(40),
      clockwise: false,
    );
    path.lineTo(size.width-40, size.height-40);
    path.arcToPoint(
      Offset(size.width, size.height), // Kết thúc cung tròn ở giữa cạnh dưới
      radius: const Radius.circular(40),
      clockwise: true,
    );
    path.lineTo(size.width, 0); // Cạnh phải
    path.close(); // Đóng đường dẫn
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
