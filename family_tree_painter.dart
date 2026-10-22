import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

/// بيرسم نفس شكل الشجرة اللي في الموكاب: جذع، فروع رئيسية وفرعية،
/// نقط ورق صغيرة، وكل فرد في دايرة عليها أول حرف من اسمه.
/// الإحداثيات مبنية على مربع مرجعي 260x215 وبتتحجم تلقائيًا حسب حجم الشاشة.
class FamilyTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 260;
    final sy = size.height / 215;
    Offset p(double x, double y) => Offset(x * sx, y * sy);

    final thick = Paint()
      ..color = AppColors.branch
      ..strokeWidth = 5 * sx
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final thin = Paint()
      ..color = AppColors.branch
      ..strokeWidth = 3 * sx
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // الجذع
    canvas.drawLine(p(130, 206), p(130, 150), thick);
    // الفروع الرئيسية (الجيل الأكبر)
    canvas.drawLine(p(130, 152), p(66, 92), thick);
    canvas.drawLine(p(130, 152), p(194, 92), thick);
    // الفروع الفرعية (الجيل اللي بعده)
    canvas.drawLine(p(97, 118), p(40, 148), thin);
    canvas.drawLine(p(163, 118), p(220, 148), thin);

    // نقط ورق للزينة
    final leafGold = Paint()..color = AppColors.gold.withOpacity(0.75);
    final leafRust = Paint()..color = AppColors.rust.withOpacity(0.6);
    for (final pt in [p(55, 78), p(78, 70), p(42, 98), p(205, 78), p(182, 70), p(218, 98)]) {
      canvas.drawCircle(pt, 3.2 * sx, leafGold);
    }
    for (final pt in [p(30, 132), p(58, 128), p(230, 132), p(202, 128)]) {
      canvas.drawCircle(pt, 2.4 * sx, leafRust);
    }

    // أفراد العائلة
    _node(canvas, p(66, 90), 15 * sx, AppColors.gold, 'ز');
    _node(canvas, p(194, 90), 15 * sx, AppColors.gold, 'إ');
    _node(canvas, p(40, 148), 12 * sx, AppColors.forest, 'ه');
    _node(canvas, p(220, 148), 12 * sx, AppColors.forest, 'ك');
  }

  void _node(Canvas canvas, Offset center, double r, Color color, String label) {
    canvas.drawCircle(center, r, Paint()..color = color);
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: GoogleFonts.arefRuqaa(
          color: Colors.white,
          fontSize: r,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.rtl,
    );
    tp.layout();
    tp.paint(canvas, center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
