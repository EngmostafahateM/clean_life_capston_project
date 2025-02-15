import 'package:clean_life_capston_project/screens/chat%20page.dart';
import 'package:clean_life_capston_project/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  int currentIndex = 0;

  // قائمة بالعناصر الموجودة في مركز المساعدة
  final List<HelpItem> helpItems = [
    HelpItem(
      title: 'Customer Service',
      icon: Icons.support_agent,
      content:
      'للاستفسارات، يمكنك الاتصال على 123-456-7890 أو مراسلتنا على support@example.com.',
    ),
    HelpItem(
      title: 'Whatsapp',
      icon: Icons.phone,
      content: 'تواصل معنا عبر واتساب على الرقم +20123456789 للحصول على دعم سريع.',
    ),
    HelpItem(
      title: 'Facebook',
      icon: Icons.facebook,
      content: 'تابعنا على فيسبوك لمعرفة آخر التحديثات: facebook.com/YourPage',
    ),
    HelpItem(
      title: 'Instagram',
      icon: Icons.camera_alt,
      content: 'تابعنا على إنستجرام: instagram.com/YourPage',
    ),
  ];

  void onNavBarTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
      // الانتقال إلى الصفحة الرئيسية
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
      // نحن بالفعل في صفحة Help Center، لا حاجة لإعادة التحميل
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
      // شريط التطبيق في الأعلى
      appBar: AppBar(
        title: Text('Help Center'),
        backgroundColor: Colors.green,
        centerTitle: true,
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
      // جسم الصفحة
      body: Container(
        color: Colors.white, // خلفية بيضاء
        child: ListView.builder(
          itemCount: helpItems.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              // تحويل العنصر الأول إلى زر
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {

                    // تنفيذ وظيفة الاتصال على سبيل المثال
                    final Uri telUri = Uri(
                      scheme: 'tel',
                      path: '1234567890',
                    );
                    if (await canLaunchUrl(telUri)) {
                      await launchUrl(telUri);
                    } else {
                      print("Cannot launch dialer");
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> chatscreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green.shade100,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Icon(
                          helpItems[index].icon,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          helpItems[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final item = helpItems[index];
              return ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    item.icon,
                    color: Colors.green,
                  ),
                ),
                title: Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade50,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      item.content,
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// موديل بسيط لتعريف عناصر مركز المساعدة
class HelpItem {
  final String title;
  final IconData icon;
  final String content;

  HelpItem({
    required this.title,
    required this.icon,
    required this.content,
  });
}
