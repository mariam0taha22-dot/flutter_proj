// lib/favorite_page.dart
import 'package:flutter/material.dart';
import 'product_model.dart';
import 'product_detail_page.dart';
import 'cart_page.dart'; // تأكدي من استيراد صفحة السلة ليعمل التنقل

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final Color primaryRose = const Color(0xFFD48C95);
  final Color darkText = const Color(0xFF4A3E3D);
  final Color bgCream = const Color(0xFFFFF8F8);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgCream,
        appBar: AppBar(
          title: Text(
            'المفضلة ',
            style: TextStyle(
              color: darkText,

              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: darkText),
        ),
        body: favoriteItems.isEmpty
            ? _buildEmptyFavorites() // إذا كانت قائمة المفضلة فارغة
            : _buildFavoritesGrid(), // إذا كانت تحتوي على منتجات
        // ------ إضافة شريط التنقل السفلي الموحد وفخم ------
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: primaryRose.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: 2, // محدد على المفضلة حالياً
            selectedItemColor: primaryRose,
            unselectedItemColor: Colors.grey.shade400,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
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
              if (index == 0) {
                // العودة للرئيسية أو إغلاق الصفحة الحالية للعودة للخلف
                Navigator.pop(context);
              } else if (index == 1) {
                // الانتقال لصفحة السلة واستبدال الصفحة الحالية لعدم تراكم الصفحات
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                ).then((_) => setState(() {}));
              } else if (index == 2) {
                // نحن بالفعل في صفحة المفضلة، لا نفعل شيء
              }
            },
          ),
        ),
      ),
    );
  }

  // واجهة عندما تكون المفضلة فارغة (تم تحسين الأبعاد والألوان لتكون أنعم)
  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryRose.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 80,
              color: primaryRose.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'قائمة المفضلة فارغة',
            style: TextStyle(
              color: darkText,

              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'اضغطي على زر القلب في المنتجات لحفظها هنا ',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // شبكة عرض منتجات المفضلة بشكل فخم وأنيق
  Widget _buildFavoritesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72, // زيادة الطول قليلاً ليعطي فخامة وراحة للعين
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final product = favoriteItems[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            ).then((_) => setState(() {}));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24), // زوايا أنعم وأكثر عصرية
              border: Border.all(color: primaryRose.withOpacity(0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: darkText.withOpacity(0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة المنتج مع زر إلغاء المفضلة الفوري
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          image: DecorationImage(
                            image: AssetImage(product.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // زر الحذف السريع بتصميم فخم ومرفوع (Floating Effect)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              product.isFavorite = false;
                              favoriteItems.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'تمت إزالة ${product.name} من المفضلة',
                                  style: const TextStyle(fontSize: 13),
                                ),
                                backgroundColor: primaryRose,
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite_rounded,
                              color: Color(0xFFE57373), // لون أحمر ناعم متناسق
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // تفاصيل المنتج (الاسم والسعر) أسفل الصورة
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: darkText,
                          fontSize: 14,

                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              color: primaryRose,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: bgCream,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: primaryRose.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
