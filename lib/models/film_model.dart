class Film {
  final String baslik;
  final String aciklama;
  final String resimYolu;

  Film({required this.baslik, required this.aciklama, required this.resimYolu});

  static List<Film> filmler = [
    Film(
      baslik: 'The Brutalist',
      aciklama: 'Film 1 Açıklaması',
      resimYolu: 'lib/assets/images/film1.jpg',
    ),
    Film(
      baslik: 'Maria',
      aciklama: 'Film 2 Açıklaması',
      resimYolu: 'lib/assets/images/film2.jpg',
    ),
    Film(
      baslik: 'Kutsal Damacana 5',
      aciklama: 'Film 3 Açıklaması',
      resimYolu: 'lib/assets/images/film3.jpg',
    ),
    Film(
      baslik: 'Son Bir Nefes',
      aciklama: 'Film 4 Açıklaması',
      resimYolu: 'lib/assets/images/film4.jpg',
    ),
    Film(
      baslik: 'Karabasan',
      aciklama: 'Film 5 Açıklaması',
      resimYolu: 'lib/assets/images/film5.jpg',
    ),
    Film(
      baslik: 'Flow',
      aciklama: 'Film 6 Açıklaması',
      resimYolu: 'lib/assets/images/film6.jpg',
    ),
  ];
}
