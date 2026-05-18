// lib/cart_page.dart
import 'package:flutter/material.dart';
import 'product_model.dart';
import 'favorite_page.dart'; // استيراد صفحة المفضلة للتبديل بينهما

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Color primaryRose = const Color(0xFFD48C95);
  final Color darkText = const Color(0xFF4A3E3D);
  final Color bgCream = const Color(0xFFFFF8F8);

  // دالة لحساب المجموع الإجمالي للمنتجات في السلة
  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgCream,
        appBar: AppBar(
          title: Text(
            'سلة التسوق ',
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
        body: cartItems.isEmpty
            ? _buildEmptyCart() // إذا كانت السلة فارغة
            : _buildCartList(), // إذا كانت السلة تحتوي على منتجات
        // ------ إضافة شريط التنقل السفلي الموحد والفخم ------
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
            currentIndex: 1, // محدد على السلة حالياً
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
                // العودة للرئيسية
                Navigator.pop(context);
              } else if (index == 1) {
                // نحن بالفعل في السلة
              } else if (index == 2) {
                // الانتقال لصفحة المفضلة واستبدال الواجهة لمنع التراكم العشوائي
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                ).then((_) => setState(() {}));
              }
            },
          ),
        ),
      ),
    );
  }

  // واجهة السلة الفارغة المحسنة
  Widget _buildEmptyCart() {
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
              Icons.shopping_bag_outlined,
              size: 80,
              color: primaryRose.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'سلتكِ فارغة حالياً',
            style: TextStyle(
              color: darkText,

              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'تصفحي المنتجات وأضيفي ما يعجبكِ إليها ',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // واجهة عرض المنتجات وحساب الإجمالي بتصميم فخم
  Widget _buildCartList() {
    return Column(
      children: [
        // قائمة المنتجات المضافة
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: primaryRose.withOpacity(0.08),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: darkText.withOpacity(0.02),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // صورة المنتج بحواف دائرية فخمة
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: AssetImage(item.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // تفاصيل المنتج (الاسم، القسم، السعر)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.category,
                            style: TextStyle(
                              color: primaryRose,
                              fontSize: 11,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.name,
                            style: TextStyle(
                              color: darkText,
                              fontSize: 15,

                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${item.price}',
                            style: TextStyle(
                              color: primaryRose,
                              fontSize: 16,

                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // زر الحذف من السلة مصمم بشكل أنعم (Soft Circle)
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE), // أحمر خفيف جداً ناعم
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFE57373),
                          size: 20,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          cartItems.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم إزالة ${item.name} من السلة',
                              style: const TextStyle(fontSize: 13),
                            ),
                            backgroundColor: const Color(0xFFE57373),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // كارد حساب الإجمالي النهائي أسفل الصفحة (تأثير كارد معلق فخم)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: darkText.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع الإجمالي:',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 16,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateTotal().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: primaryRose,
                        fontSize: 22,

                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // زر إتمام الطلب بتصميم فخم وممتد
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRose,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('تم إرسال طلبكِ بنجاح! '),
                          backgroundColor: Colors.green.shade600,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'إتمام عملية الشراء',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
