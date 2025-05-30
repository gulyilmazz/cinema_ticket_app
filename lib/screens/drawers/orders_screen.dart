import 'package:flutter/material.dart';
// import 'app_colors.dart'; // Tema dosyanızı import edin

class Appcolor {
  static const appBackgroundColor = Color(0xFF1c1c27);
  static const grey = Color(0xFF373741);
  static const buttonColor = Color(0xFFffb43b);
  static const white = Colors.white;
  static const darkGrey = Color(0xFF252532);
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.appBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Siparişlerim',
          style: TextStyle(
            color: Appcolor.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Appcolor.buttonColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Appcolor.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Appcolor.white),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Appcolor.darkGrey,
              child: TabBar(
                indicatorColor: Appcolor.buttonColor,
                labelColor: Appcolor.buttonColor,
                unselectedLabelColor: Appcolor.white.withOpacity(0.7),
                tabs: const [
                  Tab(text: 'Aktif Siparişler'),
                  Tab(text: 'Geçmiş Siparişler'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [_buildActiveOrders(), _buildPastOrders()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          orderNumber: '#SP-2025-001',
          status: 'Hazırlanıyor',
          statusColor: Colors.orange,
          date: '30 Mayıs 2025, 14:30',
          restaurant: 'Pizza Palace',
          items: [
            {'name': 'Margherita Pizza', 'quantity': 2, 'price': '45.00'},
            {'name': 'Coca Cola', 'quantity': 1, 'price': '8.00'},
          ],
          total: '53.00',
          isActive: true,
          estimatedTime: '25 dk',
        ),
        _buildOrderCard(
          orderNumber: '#SP-2025-002',
          status: 'Yola Çıktı',
          statusColor: Colors.blue,
          date: '30 Mayıs 2025, 13:15',
          restaurant: 'Burger King',
          items: [
            {'name': 'Whopper Menu', 'quantity': 1, 'price': '32.50'},
            {'name': 'Patates Kızartması', 'quantity': 1, 'price': '12.00'},
          ],
          total: '44.50',
          isActive: true,
          estimatedTime: '10 dk',
        ),
      ],
    );
  }

  Widget _buildPastOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          orderNumber: '#SP-2025-003',
          status: 'Teslim Edildi',
          statusColor: Colors.green,
          date: '29 Mayıs 2025, 19:45',
          restaurant: 'Dönerci Ahmet',
          items: [
            {'name': 'Tavuk Döner', 'quantity': 2, 'price': '30.00'},
            {'name': 'Ayran', 'quantity': 2, 'price': '10.00'},
          ],
          total: '40.00',
          rating: 5,
        ),
        _buildOrderCard(
          orderNumber: '#SP-2025-004',
          status: 'Teslim Edildi',
          statusColor: Colors.green,
          date: '28 Mayıs 2025, 20:30',
          restaurant: 'Sushi Master',
          items: [
            {'name': 'California Roll', 'quantity': 1, 'price': '25.00'},
            {'name': 'Salmon Sashimi', 'quantity': 1, 'price': '35.00'},
          ],
          total: '60.00',
          rating: 4,
        ),
        _buildOrderCard(
          orderNumber: '#SP-2025-005',
          status: 'İptal Edildi',
          statusColor: Colors.red,
          date: '27 Mayıs 2025, 12:00',
          restaurant: 'Pizza Corner',
          items: [
            {'name': 'Karışık Pizza', 'quantity': 1, 'price': '38.00'},
          ],
          total: '38.00',
        ),
      ],
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String status,
    required Color statusColor,
    required String date,
    required String restaurant,
    required List<Map<String, dynamic>> items,
    required String total,
    bool isActive = false,
    String? estimatedTime,
    int? rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Appcolor.darkGrey,
        borderRadius: BorderRadius.circular(16),
        border:
            isActive ? Border.all(color: Appcolor.buttonColor, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst kısım - Sipariş numarası ve durum
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderNumber,
                      style: const TextStyle(
                        color: Appcolor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant,
                      style: TextStyle(
                        color: Appcolor.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Appcolor.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Tarih ve tahmini süre
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Appcolor.white.withOpacity(0.7),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(
                    color: Appcolor.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                if (estimatedTime != null) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.buttonColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      estimatedTime,
                      style: const TextStyle(
                        color: Appcolor.buttonColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 16),

            // Ürünler
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Appcolor.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children:
                    items
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item['quantity']}x ${item['name']}',
                                    style: const TextStyle(
                                      color: Appcolor.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${item['price']} ₺',
                                  style: const TextStyle(
                                    color: Appcolor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Alt kısım - Toplam ve aksiyonlar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toplam: $total ₺',
                  style: const TextStyle(
                    color: Appcolor.buttonColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    if (rating != null) ...[
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 16,
                            color:
                                index < rating
                                    ? Appcolor.buttonColor
                                    : Appcolor.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (isActive)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.buttonColor,
                          foregroundColor: Appcolor.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Takip Et',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else if (status == 'Teslim Edildi')
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Appcolor.buttonColor),
                          foregroundColor: Appcolor.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Tekrar Sipariş',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
