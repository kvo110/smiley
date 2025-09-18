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
      // Main smiley face
      final facePaint = Paint()
        ..color = Colors.yellow[600]!
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, facePaint);

      // Face outline
      final outlinePaint = Paint()
        ..color = Colors.orange[800]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;
      canvas.drawCircle(center, radius, outlinePaint);

      // Left Eye (excited)
      final leftEyePaint = Paint()..color = Colors.black;
      canvas.drawCircle(center + Offset(-35, -30), 12, leftEyePaint);

      // Right Eye (winking)
      final winkPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        center + Offset(20, -30), 
        center + Offset(50, -30), 
        winkPaint
      );

      // Big smile
      final smilePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      final smileRect = Rect.fromCircle(center: center + Offset(0, 10), radius: 50);
      canvas.drawArc(smileRect, pi / 6, 2 * pi / 3, false, smilePaint);

      // Party Hat
      final hatPaint = Paint()
        ..style = PaintingStyle.fill
        ..shader = LinearGradient(
          colors: [Colors.purple, Colors.pink, Colors.orange, Colors.yellow],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(center.dx - 40, center.dy - radius - 80, 80, 80));

      final hatPath = Path();
      hatPath.moveTo(center.dx, center.dy - radius - 50); // top point
      hatPath.lineTo(center.dx - 40, center.dy - radius); // bottom left
      hatPath.lineTo(center.dx + 40, center.dy - radius); // bottom right
      hatPath.close();
      canvas.drawPath(hatPath, hatPaint);

      // Hat stripes
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

      // Hat confetti
      final pomPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(center.dx, center.dy - radius - 45), 8, pomPaint);

      // Floating confetti particles
      final confettiColors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.pink];
      final confettiPaint = Paint()..style = PaintingStyle.fill;

      for (int i = 0; i < 20; i++) {
        final random = (j) => (j * 37 + 13) % 250;
        final x = center.dx + (random(i) % 200) - 100;
        final y = center.dy + (random(i + 7) % 200) - 100;
        
        // Skip confetti too close to face
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
    final tabs = ['Text', 'Party', 'Heart', 'Emoji Dropbox'];

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
          
          // Tab 2:  Party Emoji 
          Container(
            color: Colors.yellow[50], // festive background
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Party Time! ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Floating confetti particles
                        ...List.generate(20, (index) {
                          final random = (i) => (i * 37 + 13) % 250;
                          return Positioned(
                            top: (random(index) % 280).toDouble(),
                            left: (random(index + 7) % 230).toDouble(),
                            child: Transform.rotate(
                              angle: (index * 0.5),
                              child: Container(
                                width: 12,
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.primaries[index % Colors.primaries.length],
                                ),
                              ),
                            ),
                          );
                        }),
                        
                        // Main smiley face
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[600],
                            border: Border.all(color: Colors.orange[800]!, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Left Eye (excited)
                              Positioned(
                                top: 35,
                                left: 35,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // Right Eye (winking)
                              Positioned(
                                top: 42,
                                right: 35,
                                child: Container(
                                  width: 30,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                              // Big smile
                              Positioned(
                                bottom: 25,
                                left: 25,
                                right: 25,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(110),
                                      bottomRight: Radius.circular(110),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Party Hat
                        Positioned(
                          top: -20,
                          child: Transform.rotate(
                            angle: -0.3,
                            child: CustomPaint(
                              size: const Size(80, 80),
                              painter: _PartyHatPainter(),
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
          
          // Tab 3: Heart with Button Widget
          Container(
            color: Colors.pink[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Heart Widget ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Custom painted heart
                  CustomPaint(
                    size: Size(150, 135),
                    painter: _HeartPainter(),
                  ),
                  SizedBox(height: 30),
                  // Original button
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Button pressed in ${tabs[2]} tab!'),
                          backgroundColor: Colors.red[400],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Click Me'),
                  ),
                ],
              ),
            ),
          ),

          // Tab 4 color = Light Teal, Title of tab = ListView Widget
          Container(
            color: Colors.grey[400], // light teal shade range
            child: ListView(
              children: [
                Card(
                  child: ExpansionTile(
                    title: Text('Apple Macbook'),
                    children: [
                      ExpansionTile(
                        title: Text('CPU / Processor'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Apple M1, M2, M3, or M4 chips"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Display'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Retina True Tone, Mini-LED XDR with ProMotion @ 120Hz"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Battery'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 15-22 hours"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Memory'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Unified RAM from 8GB to 12GB"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Storage'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("From 256GB to 8TB"),
                          ),
                        ],
                      ), 
                    ],
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    title: Text('ASUS Zenbook'),
                    children: [
                      ExpansionTile(
                        title: Text('CPU / Processor'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("i5, i7, i9"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Display'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Dual 14 in Lumina OLED touchscreen @ 120Hz"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Battery'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 8 hours"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Memory'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 32GB"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Storage'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 2TB M.2 NVMe PCIe 4.0 SSD"),
                          ),
                        ],
                      ), 
                    ],
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    title: Text('LG Gram'),
                    children: [
                      ExpansionTile(
                        title: Text('CPU / Processor'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("12th Gen i7"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Display'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("15.6 in Full HD (1920 x 1080) IPS Touch, 100% sRGB"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Battery'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 27 hours"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Memory'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 32GB"),
                          ),
                        ],
                      ), 
                      ExpansionTile(
                        title: Text('Storage'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Up to 2TB M.2 NVMe SSD"),
                          ),
                        ],
                      ), 
                    ],
                  ),
                ),
              ],
            ),
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

// Original Smiley Face Painter
class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 80.0;
    final facePaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, facePaint);
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center + Offset(-30, -30), 10, eyePaint);
    canvas.drawCircle(center + Offset(30, -30), 10, eyePaint);
    final smileRect = Rect.fromCircle(center: center + Offset(0, 10), radius: 50);
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round; 
    canvas.drawArc(smileRect, pi / 6, 2 * pi / 3, false, smilePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Party Hat Painter
class _PartyHatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [Colors.purple, Colors.pink, Colors.orange, Colors.yellow],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(size.width / 2, 0); // top point
    path.lineTo(0, size.height); // bottom left
    path.lineTo(size.width, size.height); // bottom right
    path.close();

    canvas.drawPath(path, paint);

    // Add colorful stripes
    final stripePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;

    for (double i = size.height; i > 0; i -= 12) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i - 8),
        stripePaint,
      );
    }

    // Add a pom-pom on top
    final pomPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, 5), 8, pomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Heart Painter
class _HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [Colors.red[300]!, Colors.red[600]!, Colors.red[800]!],
        center: Alignment.topCenter,
        radius: 1.0,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    
    // Create heart shape using mathematical curves
    final width = size.width;
    final height = size.height;
    
    // Start from the bottom point of the heart
    path.moveTo(width / 2, height * 0.85);
    
    // Left side of heart (bezier curve)
    path.cubicTo(
      width * 0.2, height * 0.6,  // control point 1
      width * 0.1, height * 0.3,  // control point 2
      width * 0.25, height * 0.15  // end point (left bump top)
    );
    
    // Top left arc
    path.cubicTo(
      width * 0.35, height * 0.05,
      width * 0.45, height * 0.05,
      width / 2, height * 0.25
    );
    
    // Top right arc
    path.cubicTo(
      width * 0.55, height * 0.05,
      width * 0.65, height * 0.05,
      width * 0.75, height * 0.15
    );
    
    // Right side of heart 
    path.cubicTo(
      width * 0.9, height * 0.3,   // control point 1
      width * 0.8, height * 0.6,   // control point 2
      width / 2, height * 0.85     // back to bottom point
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
    
    
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
      
    final highlightPath = Path();
    highlightPath.addOval(Rect.fromLTWH(width * 0.3, height * 0.2, width * 0.2, height * 0.15));
    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}