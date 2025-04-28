// Film modeli - tüm uygulama boyunca kullanılabilir
class Film {
  final String id;
  final String baslik;
  final String resimUrl;
  final String aciklama;
  final double puan;
  final String yonetmen;
  final List<String> oyuncular;
  final String vizyon;
  final String sure;
  final String kategori;
  bool isFavorite;

  Film({
    required this.id,
    required this.baslik,
    required this.resimUrl,
    required this.aciklama,
    required this.puan,
    required this.yonetmen,
    required this.oyuncular,
    required this.vizyon,
    required this.sure,
    required this.kategori,
    this.isFavorite = false,
  });

  // Örnek film verileri
  static List<Film> filmler = [
    Film(
      id: '1',
      baslik: 'The Brutalist',
      resimUrl: 'assets/images/film1.jpg',
      aciklama:
          'Savaş sonrası Amerika\'da yeni bir başlangıç arayan Macar göçmen bir mimar, vizyoner bir müşteri tarafından fark edildiğinde hayatı değişir. Ancak geçmişi ve kimliği ile yüzleşmek zorunda kalır.',
      puan: 8.5,
      yonetmen: 'Brady Corbet',
      oyuncular: ['Adrian Brody', 'Felicity Jones', 'Guy Pearce'],
      vizyon: '31 Ocak 2025',
      sure: '145 dk',
      kategori: 'Drama',
    ),
    Film(
      id: '2',
      baslik: 'Maria',
      resimUrl: 'assets/images/film2.jpg',
      aciklama:
          'Ünlü opera sanatçısı Maria Callas\'ın hayatının son günlerini anlatan etkileyici bir biyografi filmi. Sanat, tutku ve kişisel mücadeleler arasında geçen bir yaşam hikayesi.',
      puan: 7.9,
      yonetmen: 'Steven Knight',
      oyuncular: ['Angelina Jolie', 'Alba Rohrwacher', 'Valeria Golino'],
      vizyon: '15 Şubat 2025',
      sure: '120 dk',
      kategori: 'Biyografi',
      isFavorite: true,
    ),
    Film(
      id: '3',
      baslik: 'Aile Komedisi',
      resimUrl: 'assets/images/film3.jpg',
      aciklama:
          'Büyük bir aile toplantısında beklenmedik olaylar sonucu ortaya çıkan sırlar ve komik durumlar. Türk sinemasının sevilen oyuncuları bir araya geliyor.',
      puan: 6.8,
      yonetmen: 'Ali Taner Baltacı',
      oyuncular: ['Ata Demirer', 'Demet Akbağ', 'Yılmaz Erdoğan'],
      vizyon: '10 Mart 2025',
      sure: '105 dk',
      kategori: 'Komedi',
    ),
    Film(
      id: '4',
      baslik: 'Son Bir Nefes',
      resimUrl: 'assets/images/film4.jpg',
      aciklama:
          'Uluslararası bir uzay istasyonunda geçen, nefes kesen bir bilim kurgu gerilimi. Oksijen tükenmekte ve mürettebat arasındaki güven sarsılmaktadır.',
      puan: 9.0,
      yonetmen: 'David Chang',
      oyuncular: ['Mark Lee', 'John Cho', 'Michelle Yeoh'],
      vizyon: '5 Nisan 2025',
      sure: '116 dk',
      kategori: 'Bilim Kurgu',
    ),
  ];

  // Kategoriye göre filmleri döndüren fonksiyon
  static List<Film> getFilmsByCategory(String category) {
    if (category == 'Tümü') {
      return filmler;
    }
    return filmler.where((film) => film.kategori == category).toList();
  }

  static List<Film> getFavorites() {
    return filmler.where((film) => film.isFavorite).toList();
  }
}
