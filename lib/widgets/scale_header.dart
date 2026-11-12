import 'package:flutter/material.dart';

import '../core/theme.dart';

/// شعار التطبيق: درع مضيء بداخله رابط، مرسوم بالكامل داخل Flutter.
class LinkShieldMark extends StatelessWidget {
  const LinkShieldMark({super.key, this.size = 58, this.symbol = Icons.link_rounded});

  final double size;
  final IconData symbol;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: alpha(C.emerald, 0.38),
              blurRadius: size * 0.30,
              spreadRadius: size * 0.025,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.square(size),
              painter: _ShieldPainter(),
            ),
            Icon(symbol, size: size * 0.47, color: const Color(0xFFE8FFF0)),
            if (symbol == Icons.link_rounded)
              Positioned(
                bottom: size * 0.22,
                child: Container(
                  width: size * 0.34,
                  height: 2,
                  decoration: BoxDecoration(
                    color: C.emerald,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [BoxShadow(color: C.emerald, blurRadius: 7)],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final path = Path()
      ..moveTo(size.width * .5, size.height * .035)
      ..lineTo(size.width * .91, size.height * .19)
      ..lineTo(size.width * .87, size.height * .57)
      ..cubicTo(size.width * .84, size.height * .76, size.width * .67, size.height * .91, size.width * .5, size.height * .98)
      ..cubicTo(size.width * .33, size.height * .91, size.width * .16, size.height * .76, size.width * .13, size.height * .57)
      ..lineTo(size.width * .09, size.height * .19)
      ..close();

    final glow = Paint()
      ..color = alpha(C.emerald, .8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * .075
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.width * .065);
    canvas.drawPath(path, glow);

    final outer = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: [Color(0xFFB5FFB8), Color(0xFF00F45B), Color(0xFF087A31)],
      ).createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, outer);

    final innerPath = Path()
      ..moveTo(size.width * .5, size.height * .105)
      ..lineTo(size.width * .83, size.height * .225)
      ..lineTo(size.width * .80, size.height * .55)
      ..cubicTo(size.width * .77, size.height * .71, size.width * .63, size.height * .84, size.width * .5, size.height * .90)
      ..cubicTo(size.width * .37, size.height * .84, size.width * .23, size.height * .71, size.width * .20, size.height * .55)
      ..lineTo(size.width * .17, size.height * .225)
      ..close();
    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF123B22), Color(0xFF020A05), Color(0xFF03150A)],
      ).createShader(rect);
    canvas.drawPath(innerPath, fill);
    canvas.drawPath(
      innerPath,
      Paint()
        ..color = alpha(const Color(0xFFB7FFC5), .65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * .018,
    );
  }

  @override
  bool shouldRepaint(covariant _ShieldPainter oldDelegate) => false;
}

/// ترويسة Dashboard المطابقة لروح المرجع: اسم صغير، درع كبير، وحالة المحرك.
class DashboardHeroHeader extends StatelessWidget {
  const DashboardHeroHeader({super.key, this.onMenu});

  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: top + 204,
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF031D0B), Color(0xFF020A05), C.bg],
                  stops: [0, .68, 1],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(painter: _CircuitPainter(alpha(C.emerald, .30))),
          ),
          Positioned(
            top: top + 7,
            left: 10,
            right: 14,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  if (onMenu != null)
                    IconButton(
                      tooltip: 'القائمة',
                      onPressed: onMenu,
                      icon: const Icon(Icons.menu_rounded, color: C.text, size: 29),
                    ),
                  const Spacer(),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('كاشف الروابط', style: TextStyle(color: C.text, fontSize: 15, fontWeight: FontWeight.w900)),
                      Text('LINK SCANNER', style: TextStyle(color: C.emerald, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2.1)),
                    ],
                  ),
                  const SizedBox(width: 9),
                  const LinkShieldMark(size: 39),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: top + 52,
            child: Column(
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [alpha(C.emerald, .20), alpha(C.emerald, .055), Colors.transparent],
                    ),
                  ),
                  child: const Center(child: LinkShieldMark(size: 91)),
                ),
                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 7, height: 7, decoration: const BoxDecoration(color: C.emerald, shape: BoxShape.circle)),
                    const SizedBox(width: 7),
                    const Text('محرك الفحص جاهز', style: TextStyle(color: C.emerald, fontSize: 15, fontWeight: FontWeight.w900)),
                  ],
                ),
                const SizedBox(height: 3),
                const Text('افحص الروابط قبل فتحها', style: TextStyle(color: C.muted, fontSize: 11.5)),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 25,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, C.bg],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Header فرعي موحّد لباقي صفحات الفحص والأدوات.
class ScaleHeader extends StatelessWidget {
  const ScaleHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.link_rounded,
    this.onMenu,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: top + 101,
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF062713), Color(0xFF031108), C.bg],
                ),
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: _CircuitPainter(alpha(C.emerald, .18)))),
          Positioned(
            left: 14,
            right: 14,
            top: top + 12,
            bottom: 10,
            child: Row(
              children: [
                if (onMenu != null) ...[
                  IconButton(onPressed: onMenu, icon: const Icon(Icons.menu_rounded, color: C.text)),
                  const SizedBox(width: 4),
                ],
                LinkShieldMark(size: 49, symbol: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: C.text, fontSize: 19, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: C.emerald, fontSize: 11.5, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// خطوط دوائر إلكترونية بدل نمط خلايا النحل، أقرب للصورة المرجعية.
class _CircuitPainter extends CustomPainter {
  const _CircuitPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [alpha(C.emerald, .19), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(size.width * .5, size.height * .59), radius: size.width * .47));
    canvas.drawRect(Offset.zero & size, glow);

    final line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final node = Paint()..color = alpha(C.emerald, .62);

    final tracks = <List<Offset>>[
      [const Offset(.03, .08), const Offset(.03, .37), const Offset(.13, .48), const Offset(.13, .72)],
      [const Offset(.12, .00), const Offset(.12, .25), const Offset(.22, .35), const Offset(.22, .55)],
      [const Offset(.25, .00), const Offset(.25, .16), const Offset(.34, .25), const Offset(.34, .38)],
      [const Offset(.39, .00), const Offset(.39, .14), const Offset(.45, .20), const Offset(.45, .33)],
      [const Offset(.62, .00), const Offset(.62, .15), const Offset(.56, .21), const Offset(.56, .34)],
      [const Offset(.76, .00), const Offset(.76, .25), const Offset(.67, .34), const Offset(.67, .50)],
      [const Offset(.89, .00), const Offset(.89, .21), const Offset(.80, .30), const Offset(.80, .55)],
      [const Offset(.98, .08), const Offset(.98, .38), const Offset(.88, .48), const Offset(.88, .72)],
      [const Offset(.00, .70), const Offset(.17, .70), const Offset(.25, .78), const Offset(.25, .98)],
      [const Offset(1.0, .70), const Offset(.83, .70), const Offset(.75, .78), const Offset(.75, .98)],
    ];

    for (final points in tracks) {
      final path = Path();
      for (var i = 0; i < points.length; i++) {
        final p = Offset(points[i].dx * size.width, points[i].dy * size.height);
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      canvas.drawPath(path, line);
      final first = points.first;
      final last = points.last;
      for (final p in [first, last]) {
        canvas.drawCircle(Offset(p.dx * size.width, p.dy * size.height), 2.1, node);
      }
    }

    // مسارات قصيرة متفرعة تعطي إحساس لوحة الدوائر دون ازدحام وسط الشعار.
    for (var i = 0; i < 8; i++) {
      final x = i < 4 ? .04 + i * .075 : .96 - (i - 4) * .075;
      final direction = i < 4 ? 1.0 : -1.0;
      final y = .82 + (i % 3) * .045;
      final path = Path()
        ..moveTo(x * size.width, y * size.height)
        ..lineTo((x + direction * .035) * size.width, y * size.height)
        ..lineTo((x + direction * .035) * size.width, (y + .11) * size.height);
      canvas.drawPath(path, line);
      canvas.drawCircle(Offset((x + direction * .035) * size.width, (y + .11) * size.height), 1.8, node);
    }
  }

  @override
  bool shouldRepaint(covariant _CircuitPainter oldDelegate) => oldDelegate.color != color;
}
