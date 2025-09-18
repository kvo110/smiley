import 'dart:math';
import 'package:flutter/material.dart';

// main entry to flutter app
void main() {
  runApp(MyApp());
}

// Stateless Widget is like a blueprint (constructor)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

// keep track of all the controllables (public class)
class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

// (private class) unchangeable part
class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  // Select emoji state
  String selectedEmoji = 'Smiley Face';
  String userEmoji = '';

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Emoji', 'Image', 'Button', 'List View'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tab App by Kenny G. Vo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1 Smiley Face
          Container(
            color: Colors.purple[50],
            child: Column(
              children: [
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: selectedEmoji,
                  items: <String>['Smiley Face', 'Party Face', 'Heart', 'User Input'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEmoji = newValue!;
                    });
                  },
                ),
                if (selectedEmoji == 'User Input')
                  Padding(
                    padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    painter: DynamicEmojiPainter(selectedEmoji, userEmoji),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
          

          Container(

          ),
          
          Container(
          
          ),

          Container(
            
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar (
        shape: const CircularNotchedRectangle(),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}

// Emoji Dynamic Painter
class DynamicEmojiPainter extends CustomPainter {
  final String emoji;
  final String userEmoji;

  DynamicEmojiPainter(this.emoji, [this.userEmoji = '']);

  @override 
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 80.0;

    // Draws a smiley face
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

    // Draws a heart
    } else if (emoji == 'Heart') {
      final paint = Paint()..color = Colors.red;
      final path = Path();
      final x = center.dx;
      final y = center.dy;

      path.moveTo(x, y + 60); // bottom tip of the heart

      path.cubicTo(x - 60, y + 20, x - 60, y - 70, x, y - 20); // left heart lobe
      
      path.cubicTo(x + 60, y - 70, x + 60, y + 20, x, y + 60); // right heart lobe
      
      canvas.drawPath(path, paint);

    // Draws a party face with the party hat and confetti
    } else if (emoji == 'Party Face') {
      final facePaint = Paint()..color = Colors.yellow;
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

      // Draws the party hat
      final hatPaint = Paint()..color = Colors.purple;
      final hatPath = Path();
      hatPath.moveTo(center.dx, center.dy - radius - 50 );
      hatPath.lineTo(center.dx - 30, center.dy - radius);
      hatPath.lineTo(center.dx + 30, center.dy - radius);
      hatPath.close();
      canvas.drawPath(hatPath, hatPaint);

      // Draws the confetti
      final confettiPaint = Paint()..strokeWidth = 3;
      final random = Random();
      final faceRadius = 80.0;
      final confettiOuterRadius = 120.0;

      for (int i = 0; i < 20; i++) {
        final angle = random.nextDouble() * 2 * pi;
        final radius = faceRadius + random.nextDouble() * (confettiOuterRadius - faceRadius);
        final dx = center.dx + radius * cos(angle);
        final dy = center.dy + radius * sin(angle);
        confettiPaint.color = Colors.primaries[random.nextInt(Colors.primaries.length)];
        canvas.drawCircle(Offset(dx, dy), 4, confettiPaint);
      }

    // Gives the user the ability to add their own emoji to be drawn
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
