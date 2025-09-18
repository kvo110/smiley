//Team members: Ahmed Arshad &  Kenny G. Vo

import 'dart:math';
import 'package:flutter/material.dart';

// main entry to flutter app
void main() {
  runApp(MyApp());
}

// Emoji Dynamic Painter
class DynamicEmojiPainter extends CustomPainter {
  final String emoji;
  final String userEmoji;
  final bool showSteam;

  DynamicEmojiPainter(this.emoji, [this.userEmoji = '', this.showSteam = false]);

  @override 
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 80.0;

    // Smiley Face
    if (emoji == 'Smiley Face') {
      final facePaint = Paint()
        ..shader = RadialGradient(
          colors: [Colors.yellow.shade300, Colors.orange.shade700],
          center: Alignment.topLeft,
          radius: 1.0,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, facePaint);

      final eyePaint = Paint()..color = Colors.black;
      final leftEye = Rect.fromCenter(center: center + Offset(-30, -30), width: 20, height: 30);
      final rightEye = Rect.fromCenter(center: center + Offset(30, -30), width: 20, height: 30);
      canvas.drawOval(leftEye, eyePaint);
      canvas.drawOval(rightEye, eyePaint);

      final smilePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.butt;
      final smileRect = Rect.fromCircle(center: center + Offset(0, 5), radius: 50);
      canvas.drawArc(smileRect, pi / 6, 2 * pi / 3, false, smilePaint);

    // Angry Face
    } else if (emoji == 'Angry Face') {
      final facePaint = Paint()
        ..shader = RadialGradient(
          colors: [Colors.red.shade900, Colors.orange.shade600],
          center: Alignment.center,
          radius: 1.0,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, facePaint);

      final eyePaint = Paint()..color = Colors.black;
      final leftEye = Rect.fromCenter(center: center + Offset(-30, -20), width: 20, height: 30);
      final rightEye = Rect.fromCenter(center: center + Offset(30, -20), width: 20, height: 30);
      canvas.drawOval(leftEye, eyePaint);
      canvas.drawOval(rightEye, eyePaint);

      final eyebrowPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.butt;
      canvas.drawLine(center + Offset(-50, -40), center + Offset(-10, -30), eyebrowPaint);
      canvas.drawLine(center + Offset(10, -30), center + Offset(50, -40), eyebrowPaint);

      final mouthPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8;
      final mouthRect = Rect.fromCircle(center: center + Offset(0, 60), radius: 40);
      canvas.drawArc(mouthRect, pi + pi / 6, pi - pi / 3, false, mouthPaint);

      if (showSteam) {
        for (int i = -1; i <= 1; i += 2) {
          final steam1 = center + Offset(i * 70, -60);
          final steam2 = center + Offset(i * 80, -80);
          final steam3 = center + Offset(i * 90, -105);

          final steamPuffs = [steam1, steam2, steam3];
          final puffRadius = [15.0, 20.0, 25.0];

          for (int j = 0; j < steamPuffs.length; j++) {
            final gradient = RadialGradient(
              colors: [Colors.grey.shade300, Colors.grey.shade600],
              center: Alignment.center,
              radius: 0.5,
            );
            final paint = Paint()
              ..shader = gradient.createShader(Rect.fromCircle(center: steamPuffs[j], radius: puffRadius[j]));
            canvas.drawCircle(steamPuffs[j], puffRadius[j], paint);
          }
        }
      }

    
   
 /// Draws a heart
    } else if (emoji == 'Heart') {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [Colors.red[300]!, Colors.red[600]!, Colors.red[800]!],
          center: Alignment.topCenter,
          radius: 1.0,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      final path = Path();
      
      //heart shape 
      final width = size.width * 0.6; 
      final height = size.height * 0.6; 
      
      // Center the smaller heart
      final offsetX = (size.width - width) / 2;
      final offsetY = (size.height - height) / 2;
      
      // Start from the bottom point of the heart
      path.moveTo(offsetX + width / 2, offsetY + height * 0.85);
      
      // Left side of heart 
      path.cubicTo(
        offsetX + width * 0.2, offsetY + height * 0.6,  // control point 1
        offsetX + width * 0.1, offsetY + height * 0.3,  // control point 2
        offsetX + width * 0.25, offsetY + height * 0.15  // end point (left bump top)
      );
      
      // Top left arc
      path.cubicTo(
        offsetX + width * 0.35, offsetY + height * 0.05,
        offsetX + width * 0.45, offsetY + height * 0.05,
        offsetX + width / 2, offsetY + height * 0.25
      );
      
      // Top right arc
      path.cubicTo(
        offsetX + width * 0.55, offsetY + height * 0.05,
        offsetX + width * 0.65, offsetY + height * 0.05,
        offsetX + width * 0.75, offsetY + height * 0.15
      );
      
      // Right side of heart 
      path.cubicTo(
        offsetX + width * 0.9, offsetY + height * 0.3,   // control point 1
        offsetX + width * 0.8, offsetY + height * 0.6,   // control point 2
        offsetX + width / 2, offsetY + height * 0.85     // back to bottom point
      );
      
      path.close();
      
      // Draw the heart
      canvas.drawPath(path, paint);
      
      // Add a subtle shadow/outline
      final outlinePaint = Paint()
        ..color = Colors.red[900]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
        
      canvas.drawPath(path, outlinePaint);
      
      // Add a highlight
      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.fill;
        
      final highlightPath = Path();
      highlightPath.addOval(Rect.fromLTWH(offsetX + width * 0.3, offsetY + height * 0.2, width * 0.2, height * 0.15));
      canvas.drawPath(highlightPath, highlightPaint);

    // Draws a party face with the party hat and confetti
    } else if (emoji == 'Party Face') {
      final facePaint = Paint()
        ..color = Colors.yellow[600]!
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, facePaint);

      final outlinePaint = Paint()
        ..color = Colors.orange[800]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;
      canvas.drawCircle(center, radius, outlinePaint);

      final leftEyePaint = Paint()..color = Colors.black;
      canvas.drawCircle(center + Offset(-35, -30), 12, leftEyePaint);

      final winkPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        center + Offset(20, -30), 
        center + Offset(50, -30), 
        winkPaint
      );

      final smilePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      final smileRect = Rect.fromCircle(center: center + Offset(0, 10), radius: 50);
      canvas.drawArc(smileRect, pi / 6, 2 * pi / 3, false, smilePaint);

      final hatPaint = Paint()
        ..style = PaintingStyle.fill
        ..shader = LinearGradient(
          colors: [Colors.purple, Colors.pink, Colors.orange, Colors.yellow],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(center.dx - 40, center.dy - radius - 80, 80, 80));

      final hatPath = Path();
      hatPath.moveTo(center.dx, center.dy - radius - 50);
      hatPath.lineTo(center.dx - 40, center.dy - radius);
      hatPath.lineTo(center.dx + 40, center.dy - radius);
      hatPath.close();
      canvas.drawPath(hatPath, hatPaint);

      final stripePaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 4;

      for (double i = 50; i > 0; i -= 12) {
        canvas.drawLine(
          Offset(center.dx - (40 * i / 50), center.dy - radius - i),
          Offset(center.dx + (40 * i / 50), center.dy - radius - i + 8),
          stripePaint,
        );
      }

      final pomPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(center.dx, center.dy - radius - 45), 8, pomPaint);

      final confettiColors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.pink];
      final confettiPaint = Paint()..style = PaintingStyle.fill;

      for (int i = 0; i < 20; i++) {
        final random = (j) => (j * 37 + 13) % 250;
        final x = center.dx + (random(i) % 200) - 100;
        final y = center.dy + (random(i + 7) % 200) - 100;
        
        final distance = sqrt(pow(x - center.dx, 2) + pow(y - center.dy, 2));
        if (distance > radius + 20) {
          confettiPaint.color = confettiColors[i % confettiColors.length];
          canvas.save();
          canvas.translate(x, y);
          canvas.rotate(i * 0.5);
          canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 12, height: 6), confettiPaint);
          canvas.restore();
        }
      }

    // User Input Emoji
    } else if (emoji == 'User Input' && userEmoji.isNotEmpty) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: userEmoji,
          style: TextStyle(fontSize: 100),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final offset = Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// MyApp is now a StatelessWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedEmoji = 'Smiley Face';
  String userEmoji = '';
  bool showSteam = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Emoji App by Kenny G. Vo & Ahmed Arshad'),
          backgroundColor: Colors.blue[600],
        ),
        body: Container(
          color: Colors.purple[50],
          child: Column(
            children: [
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedEmoji,
                items: <String>['Smiley Face', 'Angry Face', 'Party Face', 'Heart', 'User Input']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedEmoji = newValue!;
                    showSteam = false;
                  });
                },
              ),
              if (selectedEmoji == 'Angry Face')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showSteam = !showSteam;
                    });
                  },
                  child: Text(showSteam ? 'Hide Steam' : 'View Steam'),
                ),
              if (selectedEmoji == 'User Input')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Please Enter Your Chosen Emoji',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userEmoji = value;
                      });
                    },
                  ),
                ),
              SizedBox(height: 10),
              Expanded(
                child: CustomPaint(
                  painter: DynamicEmojiPainter(selectedEmoji, userEmoji, showSteam),
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}