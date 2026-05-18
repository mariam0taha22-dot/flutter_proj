// lib/product_detail_page.dart
import 'package:flutter/material.dart';
import 'product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Color primaryRose = const Color(0xFFD48C95);
  final Color darkText = const Color(0xFF4A3E3D);
  final Color bgCream = const Color(0xFFFFF8F8);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgCream,
        // جعل الـ AppBar يطفو شفافاً تماماً فوق الصورة
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: darkText,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  widget.product.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: const Color(0xFFE57373), // لون أحمر ناعم متناسق
                ),
                onPressed: () {
                  setState(() {
                    widget.product.isFavorite = !widget.product.isFavorite;
                    if (widget.product.isFavorite) {
                      if (!favoriteItems.contains(widget.product)) {
                        favoriteItems.add(widget.product);
                      }
                    } else {
                      favoriteItems.remove(widget.product);
                    }
                  });
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. عرض صورة المنتج بتصميم ممتد وانسيابي "واو"
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: darkText.withOpacity(0.06),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(widget.product.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 2. تفاصيل المنتج داخل كارد متكامل يتداخل برقة وفخامة
              Transform.translate(
                offset: const Offset(0, -20), // حركة تداخل فخمة للأعلى قليلاً
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38),
                    ),
                    border: Border.all(
                      color: primaryRose.withOpacity(0.05),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: darkText.withOpacity(0.02),
                        blurRadius: 20,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // خط ناعم أعلى الكارد يعطي إيحاء بالفخامة والترتيب
                      Center(
                        child: Container(
                          width: 50,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // القسم التابع له المنتج
                      Text(
                        widget.product.category.toUpperCase(),
                        style: TextStyle(
                          color: primaryRose,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,

                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // اسم المنتج والسعر ديناميكياً بتناسق رائع
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: TextStyle(
                                color: darkText,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,

                                height: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '\$${widget.product.price}',
                            style: TextStyle(
                              color: primaryRose,
                              fontSize: 24,

                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // عنوان الوصف
                      Text(
                        'عن المنتج ✨',
                        style: TextStyle(
                          color: darkText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // نص الوصف الديناميكي بانسيابية وخط مريح للقرأة
                      Text(
                        widget.product.description,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,

                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 35),

                      // زر الإضافة إلى السلة التفاعلية الفخم والممتد
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRose,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            shadowColor: primaryRose.withOpacity(0.3),
                          ),
                          onPressed: () {
                            if (!cartItems.contains(widget.product)) {
                              cartItems.add(widget.product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'تم إضافة ${widget.product.name} إلى السلة! 🛍️',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  backgroundColor: primaryRose,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'المنتج موجود بالفعل في السلة!',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  backgroundColor: darkText.withOpacity(0.9),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.shopping_bag_rounded,
                            size: 20,
                          ),
                          label: const Text(
                            'إضافة إلى السلة التفاعلية',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
