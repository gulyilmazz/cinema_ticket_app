// Film detay sayfası
import 'package:cinemaa/models/film_model.dart';
import 'package:cinemaa/screens/tickets/ticket_buy/bilet_al_sayfasi.dart';
import 'package:flutter/material.dart';

class FilmDetaySayfasi extends StatefulWidget {
  final Film film;

  const FilmDetaySayfasi({Key? key, required this.film}) : super(key: key);

  @override
  _FilmDetaySayfasiState createState() => _FilmDetaySayfasiState();
}

class _FilmDetaySayfasiState extends State<FilmDetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 152, 147, 196),
              const Color.fromARGB(255, 211, 208, 218),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Üstteki resim ve app bar
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(widget.film.resimUrl, fit: BoxFit.fill),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.film.baslik,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      widget.film.puan.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      widget.film.kategori,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Favori butonu
                          IconButton(
                            icon: Icon(
                              widget.film.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.film.isFavorite =
                                    !widget.film.isFavorite;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.film.isFavorite
                                        ? '${widget.film.baslik} favorilere eklendi'
                                        : '${widget.film.baslik} favorilerden çıkarıldı',
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 9, 14, 10),
              iconTheme: IconThemeData(
                color: const Color.fromARGB(255, 10, 223, 230),
              ),
            ),

            // İçerik
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bilgiler
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Yönetmen', widget.film.yonetmen),
                          _buildInfoRow(
                            'Oyuncular',
                            widget.film.oyuncular.join(', '),
                          ),
                          _buildInfoRow('Vizyon Tarihi', widget.film.vizyon),
                          _buildInfoRow('Süre', widget.film.sure),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Açıklama
                    Text(
                      'Film Açıklaması',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.film.aciklama,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),

                    SizedBox(height: 24),

                    // Bilet al butonu
                    InkWell(
                      onTap: () {
                        // Bilet sayfasına yönlendirme
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => TicketBuyScreen(film: widget.film),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 9, 14, 10),
                              const Color.fromARGB(255, 118, 113, 167),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color.fromARGB(255, 10, 222, 230),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Bilet Al',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
