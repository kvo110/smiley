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
    final tabs = ['Text', 'Image', 'Button', 'List View'];

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
            child: Center(
              child: CustomPaint(
                painter: SmileyPainter(),
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
          ),
          
          // Tab 2 color = Black, Title of tab = Image Widget
          Container(
            color: Colors.black, // black background 
            child: Center(
              child: Image.network(
                'https://images.unsplash.com/photo-1469598614039-ccfeb0a21111?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: 500,
                height: 500, 
                // loading icon
                loadingBuilder: (contextm, child, progress) {
                  if (progress == null) return child;
                  return CircularProgressIndicator();
                },
                // pops an error if image fails to load
                errorBuilder: (context, child, tracker) => Icon(Icons.error, size: 50, color: Colors.red),
              ), 
            ),
          ),
          
          // Tab 3 color = Light Blue, Title of tab = Button Widget
          Container(
            color: Colors.blue[50], // light blue shade range
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Button pressed in ${tabs[2]} tab!'),
                    ),
                  );
                },
                child: Text('Click Me'),
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

// Smiley Face Painter
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
