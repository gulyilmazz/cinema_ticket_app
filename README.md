## Sinemalarda.. (cinema_ticket_app)

Türkçe bir sinema bilet uygulaması (Flutter) — gösterimler, salonlar, koltuk seçimi ve kullanıcı biletleri yönetimi içeren mobil uygulama iskeleti.

Bu repo, Flutter ile yazılmış bir mobil uygulama projesidir. Uygulama temel olarak şunları içerir:

- Kullanıcı kimlik (token) saklama (SharedPreferences) için yardımcı sınıf: `lib/core/storage.dart`
- Ana ekran ve alt navigasyon (`lib/screens/main_screen.dart`) — Ana Sayfa, Biletler, Profil
- Birçok ekran (film listeleri, salonlar, seanslar, koltuk seçimi, ödeme, profil) `lib/screens/` içinde
- Modeller `lib/models/` içinde (filmler, salonlar, seanslar, biletler vb.)

Not: Proje kökünde çok sayıda platform klasörü (android/ios/web/windows/macOS/linux) ve `assets/images/` altında görseller vardır.

## Hızlı başlangıç

Geliştirme ortamı hazırsa (Flutter SDK yüklü):

1. Depoyu klonla veya kopyala.
2. Proje klasörüne gir:

	cd <proje-dizini>

3. Bağımlılıkları yükle:

	flutter pub get

4. Uygulamayı çalıştır:

	flutter run

Yerel bir cihaz veya emulator seçin (Android Studio / VS Code cihaz listesi üzerinden).


## Türkçe — Sinemalarda.. (cinema_ticket_app)

Türkçe bir sinema bilet uygulaması (Flutter) — gösterimler, salonlar, koltuk seçimi ve kullanıcı biletleri yönetimi içeren mobil uygulama iskeleti.

Bu repo, Flutter ile yazılmış bir mobil uygulama projesidir. Uygulama temel olarak şunları içerir:

- Kullanıcı kimlik (token) saklama (SharedPreferences) için yardımcı sınıf: `lib/core/storage.dart`
- Ana ekran ve alt navigasyon (`lib/screens/main_screen.dart`) — Ana Sayfa, Biletler, Profil
- Birçok ekran (film listeleri, salonlar, seanslar, koltuk seçimi, ödeme, profil) `lib/screens/` içinde
- Modeller `lib/models/` içinde (filmler, salonlar, seanslar, biletler vb.)
- `assets/images/` — Uygulamada kullanılan görseller ve animasyonlar.

Not: Proje kökünde çok sayıda platform klasörü (android/ios/web/windows/macOS/linux) ve `assets/images/` altında görseller vardır.

### Hızlı başlangıç

Geliştirme ortamı hazırsa (Flutter SDK yüklü):

1. Depoyu klonla veya kopyala.
2. Proje klasörüne gir:

	cd <proje-dizini>

3. Bağımlılıkları yükle:

	flutter pub get

4. Uygulamayı çalıştır:

	flutter run

Yerel bir cihaz veya emulator seçin (Android Studio / VS Code cihaz listesi üzerinden).

### Proje yapısı (seçilen dosyalar)

- `lib/main.dart` — Uygulamanın giriş noktası, `SplashScreen` ile başlar.
- `lib/screens/main_screen.dart` — Alt sekmeler (Ana Sayfa, Biletler, Profil) ve drawer.
- `lib/core/storage.dart` — `SharedPreferences` tabanlı token, şehir ve salon id saklama yardımcıları.
- `lib/models/` — API cevaplarını temsil eden model sınıfları (örneğin `movies_response.dart`).
- `assets/images/` — Uygulamada kullanılan görseller ve animasyonlar.

### Bağımlılıklar

Projede kullanılan öne çıkan paketler (`pubspec.yaml`):

- flutter
- http — API çağrıları için
- shared_preferences — küçük veri / token saklama
- lottie — animasyonlar
- intl — tarih-locale formatlama
- flutter_staggered_animations, flutter_spinkit — UI animasyonları

### Çalışma akışı ve notlar

- Uygulama `SplashScreen` ile başlar ve ardından kullanıcı ana ekrana (`MainScreen`) yönlendirilir.
- `MainScreen` içinde iki ana bölüm: içerik sayfaları ve alt navigasyon.
- `core/storage.dart` içinde anahtar isimlerinde ufak yazım hatası (ör: `_cinema"_id`) görüyorum; bu anahtarlar düzeltilmezse `SharedPreferences` okuma/yazma hatası olabilir.

### Bilinen küçük eksiklikler / öneriler

1. `lib/core/storage.dart` içindeki `_cinema"_id` sabitindeki tırnak hatası düzeltilmeli.
2. `pubspec.yaml` dosyasında proje adı `cinemaa` olarak görünüyor — isterseniz `cinema_ticket_app` veya uygun bir paket adıyla güncelleyebilirsiniz.
3. README'ye ekran görüntüleri (assets/screenshots) ve çalıştırma örnekleri eklenebilir.
4. API base URL ve kimlik bilgileri environment/secret olarak saklanmalı (örn. .env veya CI secret). Şu anda `services/` altında `client_service.dart` gibi dosyalar var; hassas verileri oraya gömülmemeli.

### Geliştirme ve test önerileri

- Kod formatlama: `dart format .`
- Statik analiz: `flutter analyze`
- Test çalıştırma: `flutter test` (mevcut testler `test/` içinde)

### Nasıl katkıda bulunulur

1. Fork/branch açın.
2. Değişiklikleri küçük commit'lerle gönderin.
3. Pull request açarken ne değiştiğini ve nasıl test edildiğini açıklayın.

### Lisans

Bu repo bir lisans dosyası içermiyorsa, lütfen lisans ekleyin (örn. MIT) veya proje sahibinden izin alın.

---

## English — Sinemalarda.. (cinema_ticket_app)

This is a Turkish cinema ticket mobile app skeleton built with Flutter. It includes screens for movies, cinema halls, showtimes, seat selection and user tickets.

The repository contains:

- A helper class for saving user auth token and simple keys: `lib/core/storage.dart`
- Main app screen and bottom navigation: `lib/screens/main_screen.dart`
- Many other screens under `lib/screens/` (movies, halls, showtimes, seats, payment, profile)
- API models under `lib/models/` and assets under `assets/images/`

### Quick start

Make sure you have Flutter SDK installed.

1. Clone the repo.
2. Change directory to the project root:

	cd <project-directory>

3. Install packages:

	flutter pub get

4. Run the app:

	flutter run

Choose a connected device or emulator from your IDE.

### Project highlights

- `lib/main.dart` — app entry (uses `SplashScreen`).
- `lib/screens/main_screen.dart` — bottom navigation (Home, Tickets, Profile) + drawer.
- `lib/core/storage.dart` — SharedPreferences helpers for token, city and cinema ids.
- `lib/models/` — API response models (e.g. `movies_response.dart`).

### Dependencies

See `pubspec.yaml`. Notable packages: `http`, `shared_preferences`, `lottie`, `intl`, UI animation helpers.

### Notes & known issues

- There's a small typo in `lib/core/storage.dart` (`_cinema"_id`) that should be fixed to avoid SharedPreferences key mismatch.
- The package name in `pubspec.yaml` is `cinemaa` — consider renaming to `cinema_ticket_app` if you want consistency.
- Keep API keys and base URLs out of source code — use environment variables or CI secrets.

### Dev tips

- Format: `dart format .`
- Analyze: `flutter analyze`
- Tests: `flutter test`

### Contributing

1. Fork the repo and create a branch.
2. Make small, focused commits.
3. Open a PR with description and testing notes.

---

If you want, I can also:
- Fix the `lib/core/storage.dart` key typo and commit the change.
- Add sample screenshots under `assets/screenshots/` and link them in README.
- Add a simple GitHub Actions workflow that runs format/analyze/test on PRs.
