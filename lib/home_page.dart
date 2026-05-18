// lib/home_page.dart
import 'package:flutter/material.dart';
import 'product_model.dart';
import 'custom_drawer.dart';
import 'cart_page.dart'; // استدعاء صفحة السلة لربطها بالتنقل السفلي
import 'favorite_page.dart'; // استدعاء صفحة المفضلة لربطها بالتنقل السفلي
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 🎨 الألوان المعتمدة والثابتة في التطبيق
  final Color primaryRose = const Color(0xFFD48C95);
  final Color darkText = const Color(0xFF4A3E3D);
  final Color bgCream = const Color(0xFFFFF8F8);

  // القسم المحدد حالياً للفلترة
  String selectedCategory = 'الكل';

  // قائمة الأقسام
  final List<Map<String, dynamic>> categories = [
    {'name': 'الكل', 'icon': Icons.grid_view_rounded},
    {'name': 'ملابس', 'icon': Icons.checkroom_rounded},
    {'name': 'لوازم جامعية', 'icon': Icons.auto_stories_rounded},
    {'name': 'إكسسوارات', 'icon': Icons.watch_rounded},
    {'name': 'منتجات عناية', 'icon': Icons.spa_rounded},
    {'name': 'إكسسوارات رقمية', 'icon': Icons.headphones_rounded},
  ];

  // وظيفة إضافة المنتج إلى السلة والتأكد من عدم تكراره
  void addToCart(Product product) {
    setState(() {
      if (!cartItems.contains(product)) {
        cartItems.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إضافة ${product.name} إلى السلة! 🛍️'),
            backgroundColor: primaryRose,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('المنتج موجود بالفعل في السلة!'),
            backgroundColor: darkText,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // فلترة القائمة بناءً على القسم المختار
    final filteredProducts = selectedCategory == 'الكل'
        ? dummyProducts
        : dummyProducts.where((p) => p.category == selectedCategory).toList();

    return Directionality(
      textDirection: TextDirection.rtl, // دعم كامل للغة العربية
      child: Scaffold(
        backgroundColor: bgCream,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: darkText),
          title: Text(
            'Mini Marketplace',
            style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none_rounded, color: darkText),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const CustomNavigationDrawer(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // 1. شريط البحث المطور بنعومة وثبات بظلال خفيفة جداً
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: darkText.withOpacity(0.03),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(color: darkText, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'ابحثي عن منتجاتكِ الجميلة...',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.black38,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: darkText.withOpacity(0.03),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: primaryRose,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // 2. البنر الإعلاني الأنيق مع دعم إضافة صورة مخصصة ومحسنة
                Container(
                  width: double.infinity,
                  height:
                      140, // تحديد طول ثابت للبنر لضمان تناسق الصورة والكتابة
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryRose, primaryRose.withOpacity(0.85)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryRose.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // نصوص البنر والزر
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'مجموعة جديدة\nحصرياً لأجلكِ ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: primaryRose,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'تسوقي الآن',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // صورة البنر الإعلاني محاطة بقص احترافي للحواف الدائرية للبنر
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ), // مسافة بسيطة من اليسار
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/non.jpeg', // ⚠️ استبدلي المسار بمسار صورتكِ الفعلي في مجلد الـ assets
                            height: 140,
                            width: 130,
                            fit: BoxFit
                                .cover, // ملء المساحة بنعومة دون تشويه الصورة
                            errorBuilder: (context, error, stackTrace) {
                              // ويدجت احتياطي في حال عدم عثور التطبيق على مسار الصورة المدخل
                              return Container(
                                width: 100,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.auto_awesome_rounded,
                                  size: 50,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // 3. عرض الأقسام بشكل دائرى حديث متحرك ونظيف
                Text(
                  'الأقسام',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected =
                          selectedCategory == categories[index]['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = categories[index]['name'];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryRose
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: isSelected
                                          ? primaryRose.withOpacity(0.2)
                                          : darkText.withOpacity(0.02),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  categories[index]['icon'],
                                  color: isSelected
                                      ? Colors.white
                                      : primaryRose,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                categories[index]['name'],
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: isSelected
                                      ? primaryRose
                                      : darkText.withOpacity(0.8),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),

                // 4. شريط العناوين والتنقل الفرعي للمنتجات
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المختارات الشائعة ($selectedCategory)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    Text(
                      'عرض الكل',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryRose,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 5. شبكة عرض المنتجات المتناسقة والأنيقة كلياً
                filteredProducts.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text(
                            'لا توجد منتجات في هذا القسم حالياً ,انتظرونا قريباً',
                            style: TextStyle(
                              color: darkText.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.70,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              ).then((_) => setState(() {}));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: darkText.withOpacity(0.02),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                product.imagePath,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Container(
                                            height: 32,
                                            width: 32,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.9,
                                              ),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: Icon(
                                                product.isFavorite
                                                    ? Icons.favorite_rounded
                                                    : Icons
                                                          .favorite_border_rounded,
                                                color: const Color(0xFFE57373),
                                                size: 18,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  product.isFavorite =
                                                      !product.isFavorite;
                                                  if (product.isFavorite) {
                                                    if (!favoriteItems.contains(
                                                      product,
                                                    )) {
                                                      favoriteItems.add(
                                                        product,
                                                      );
                                                    }
                                                  } else {
                                                    favoriteItems.remove(
                                                      product,
                                                    );
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: darkText,
                                        fontSize: 13,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price}',
                                          style: TextStyle(
                                            color: primaryRose,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => addToCart(product),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryRose.withOpacity(
                                                0.12,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              '+ إضافة',
                                              style: TextStyle(
                                                color: primaryRose,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),

        // 6. شريط التنقل السفلي المعدل والمحسّن بصرياً بالكامل
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: primaryRose,
          unselectedItemColor: Colors.grey.shade400,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_bag_rounded),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE57373),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: 'السلة',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'المفضلة',
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              ).then((_) => setState(() {}));
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              ).then((_) => setState(() {}));
            }
          },
        ),
      ),
    );
  }
}
