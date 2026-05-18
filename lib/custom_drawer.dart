// lib/custom_drawer.dart
import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'favorite_page.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🎨 الألوان المعتمدة والموحدة في التطبيق
    const Color primaryRose = Color(0xFFD48C95);
    const Color darkText = Color(0xFF4A3E3D);
    const Color bgCream = Color(0xFFFFF8F8);

    return Directionality(
      textDirection:
          TextDirection.rtl, // لضمان اتساق الواجهة من اليمين لليسار بالكامل
      child: Drawer(
        elevation: 5,
        child: Container(
          color: bgCream, // 👈 استخدام لون الخلفية المعتمد
          child: Column(
            children: [
              // 1️⃣ هيدر ترحيبي فخم متناسق مع هوية التطبيق
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 30,
                  right: 25,
                  left: 25,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryRose.withOpacity(0.85),
                      primaryRose, // 👈 استخدام اللون الوردي المعتمد
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryRose.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الرمز الشخصي المحاط بإطار مشع أنيق
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              bgCream, // 👈 استخدام لون الخلفية المعتمد
                          child: Icon(
                            Icons.person_3_rounded,
                            color:
                                primaryRose, // 👈 استخدام اللون الوردي المعتمد
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'أهلاً بكِ، يا جميلة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black12,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'كل ما تحبينه في مكان واحد جميل.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // 2️⃣ قائمة العناصر والروابط الجانبية
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    _buildDrawerItem(
                      icon: Icons.home_rounded,
                      title: 'الرئيسية',
                      textColor: darkText, // 👈 استخدام لون النص المعتمد
                      iconColor: primaryRose, // 👈 استخدام اللون الوردي المعتمد
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildDrawerItem(
                      icon: Icons.grid_view_rounded,
                      title: 'الأقسام',
                      textColor: darkText,
                      iconColor: primaryRose,
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildDrawerItem(
                      icon: Icons.shopping_bag_rounded,
                      title: 'سلة المشتريات',
                      textColor: darkText,
                      iconColor: primaryRose,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.favorite_rounded,
                      title: 'منتجاتي المفضلة',
                      textColor: darkText,
                      iconColor: primaryRose,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritePage(),
                          ),
                        );
                      },
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 12,
                      ),
                      child: Divider(color: Color(0xFFF4ECE8), thickness: 1.2),
                    ),

                    _buildDrawerItem(
                      icon: Icons.info_rounded,
                      title: 'عن التطبيق',
                      textColor: darkText,
                      iconColor: primaryRose,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // 3️⃣ التوقيع السفلي الناعم
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'صُنع بكل حب ',
                      style: TextStyle(
                        color: darkText.withOpacity(
                          0.35,
                        ), // 👈 متناسق مع لون النص الداكن
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.favorite_rounded,
                      color: primaryRose,
                      size: 13,
                    ), // 👈 الوردي المعتمد
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة بناء عناصر القائمة بلمسات التصميم الحديث والمريح للمس
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 13,
          color: textColor.withOpacity(0.3),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        tileColor: Colors.transparent,
        hoverColor: iconColor.withOpacity(0.05),
        onTap: onTap,
      ),
    );
  }
}
