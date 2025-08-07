# ELAN DIABETES V2

### Instalasi
- Pastikan sudah menginstal Flutter dan Dart.
- Clone repository ini:
```bash
git clone <repo-url>
cd elan_diabetes
```
- Install dependencies:
```bash
flutter pub get
```

### Build & Run
- Untuk menjalankan aplikasi di emulator/device:
```bash
flutter run
```
- Untuk membangun kode generator:
```bash
dart run build_runner build --delete-conflicting-outputs
```
- Untuk build apk split-per-abi (Debug):
```bash
flutter build apk --split-per-abi
```
- Untuk build release (Android):
```bash
flutter build apk --release
```

### Struktur Folder
- lib - Kode utama aplikasi (core, data, domain, presentation, dsb)
- assets - Gambar, ikon, dan aset lainnya
- android, ios, web, windows, linux, macos - Kode platform spesifik
- test - Unit dan widget tests
