import 'package:flutter/material.dart';
import 'package:sturrd_flutter/core/constants/colors.dart';
import 'package:sturrd_flutter/core/constants/textstyles.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RoundedImageWidget extends StatelessWidget {
  final bool isOnline;
  final bool showRanking;
  final double ranking;
  final String name;
  final String imagePath;
  final double imageSize = 80.0;

  RoundedImageWidget(
      {Key key,
      this.isOnline = false,
      this.showRanking = false,
      this.ranking,
      this.imagePath,
      this.name = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: imageSize + 8.0,
          child: Stack(
            children: <Widget>[
              CustomPaint(
                painter: RoundedImageBorder(isOnline: isOnline),
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  child: ClipOval(
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),
              ),
              showRanking
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: ClipOval(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            gradient: Colours.kAppGradient,
                          ),
                          child: Center(
                            child: Text('${ranking.toInt()}',
                                style: Textstyles.kRankTextStyle),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        if (name != null) Text(name, style: Textstyles.kBodyTextStyle)
      ],
    );
  }
}

class RoundedImageBorder extends CustomPainter {
  final bool isOnline;
  RoundedImageBorder({this.isOnline});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width * 0.5, size.height * 0.5);

    Paint borderPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    if (isOnline) {
      borderPaint.shader = Colours.kAppGradient.createShader(
          Rect.fromCircle(center: center, radius: size.width * 0.5));
    } else {
      borderPaint.color = Colours.kTertiaryTextColor;
    }

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90), math.radians(360), false, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
