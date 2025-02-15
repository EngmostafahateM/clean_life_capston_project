import 'package:clean_life_capston_project/resources/color_manager.dart';
import 'package:clean_life_capston_project/screens/helpcenter.dart';
import 'package:clean_life_capston_project/widgets/carditem.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int basketCount = 1;
  int currentIndex = 0;

  final List<Map<String, String>> items = [
    {
      "title": "Arduino_Uno",
      "des": "The Arduino Uno is a microcontroller board with digital and analog I/O, a USB port, and a power jack, ideal for prototyping and IoT projects.",
      "image": "assets/images/Arduino Uno.png"
    },
    {
      "title": "smart box",
      "des": "A box containing a sensor",
      "image": "assets/images/boximage1.png"
    },
    {
      "title": "Inductive Proximity",
      "des": "This is an Inductive Proximity Sensor, used for detecting metal objects without contact. It operates via an electromagnetic field and is commonly used in industrial and robotics applications.",
      "image": "assets/images/Inductive Proximity .png"
    },
    {
      "title": "IR Obstacle Sensor",
      "des": "The IR Obstacle Sensor detects obstacles using infrared light and is adjustable via a potentiometer. It’s used in robotics and security systems.",
      "image": "assets/images/IR Obstacle Sensor.png"
    },
  ];

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'cleanlifelife625@gmail.com',
      queryParameters: {
        'subject': 'Basket Order Request',
        'body': 'Requested Baskets: $basketCount'
      },
    );

    try {
      // استخدام LaunchMode.externalApplication لتشغيل تطبيق البريد الخارجي
      if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        print("Could not launch email client");
      }
    } catch (e) {
      print("Error launching email client: $e");
    }
  }

  void onNavBarTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
      // الصفحة الرئيسية، يمكن تحديث الصفحة أو عدم فعل شيء
        break;
      case 1:
      // الانتقال إلى صفحة مركز المساعدة
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpCenterPage()),
        );
        break;
      case 2:
      // تنفيذ عملية تسجيل الخروج
        logout();
        break;
    }
  }

  void logout() {
    // هنا يمكنك تنفيذ عملية تسجيل الخروج وإعادة توجيه المستخدم إلى صفحة تسجيل الدخول
    print("Logging out...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onNavBarTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center),
            label: "Help center",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "logout",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorManager.lightprimary, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    title: items[index]["title"]!,
                    imageUrl: items[index]["image"]!,
                    des: items[index]["des"]!,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          if (basketCount > 1) basketCount--;
                        });
                      },
                    ),
                    Text(
                      '$basketCount',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          basketCount++;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: sendEmail,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text("send order"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
