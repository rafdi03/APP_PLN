<!--
██╗   ██╗ █████╗ ██████╗ ██████╗     ██████╗ ██╗      ███╗   ██╗
██║   ██║██╔══██╗██╔══██╗██╔══██╗    ██╔══██╗██║      ████╗  ██║
██║   ██║███████║██████╔╝██║  ██║    ██████╔╝██║      ██╔██╗ ██║
╚██╗ ██╔╝██╔══██║██╔═══╝ ██║  ██║    ██╔═══╝ ██║      ██║╚██╗██║
 ╚████╔╝ ██║  ██║██║     ██████╔╝    ██║     ███████╗ ██║ ╚████║
  ╚═══╝  ╚═╝  ╚═╝╚═╝     ╚═════╝     ╚═╝     ╚══════╝ ╚═╝  ╚═══╝
             Digitalisasi Manajemen Proyek Ketenagalistrikan
-->


<div align="center">

<img src="https://img.shields.io/badge/PLN%20Sumba-Project-blue?style=for-the-badge&logo=powerbi&logoColor=white"/>
<img src="https://img.shields.io/badge/Flutter-Mobile-blue?style=for-the-badge&logo=flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge&logo=github"/>
<img src="https://img.shields.io/badge/License-Unlicensed-lightgrey?style=for-the-badge"/>

</div>

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/placeholder/banner-app-pln.png" alt="APP PLN Banner" style="border-radius: 12px; box-shadow: 0 0 24px #0084d1;">
</p>

<h1 align="center">APP_PLN</h1>
<p align="center"><b>
Aplikasi digitalisasi manajemen proyek kelistrikan untuk <br>
UNIT PELAKSANA PROYEK KETENAGALISTRIKAN SUMBA <br>
PT. PLN (Persero) UNIT INDUK WILAYAH NUSA TENGGARA TIMUR
</b></p>

---

## 🎯 **Tujuan & Visi**

APP_PLN hadir sebagai solusi digital untuk mengubah proses pengelolaan proyek kelistrikan dari manual menjadi otomatis dan efisien. Platform ini membantu tim PLN Sumba dalam monitoring, pelaporan, dan kolaborasi proyek secara real-time, aman, serta terintegrasi.

- **Efisiensi**: Semua data dan proses terpusat, minim human error
- **Transparansi**: Laporan dan progres mudah dipantau
- **Akurasi**: Data selalu up-to-date dan dapat diakses kapan saja

---

## 🖥️ **Tampilan & Arsitektur**

<table>
  <tr>
    <td align="center"><b>Dashboard Monitoring</b></td>
    <td align="center"><b>Manajemen Proyek</b></td>
    <td align="center"><b>Laporan & Notifikasi</b></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/placeholder/dashboard_pln.png" width="250"></td>
    <td><img src="https://user-images.githubusercontent.com/placeholder/project_mgmt.png" width="250"></td>
    <td><img src="https://user-images.githubusercontent.com/placeholder/report_notify.png" width="250"></td>
  </tr>
</table>

```
+---------------------------------------------------------------+
|                        Arsitektur APP_PLN                    |
+-------------------+        +-------------------+              |
|   Mobile Client   |<------>|   REST API/BE     |---+          |
+-------------------+        +-------------------+   |          |
                                         |            |         |
                                         v            v         |
                                 +---------------------------+  |
                                 |       Database PLN        |  |
                                 +---------------------------+  |
```

---

## ✨ **Fitur Unggulan**

| Fitur                      | Penjelasan                                                                                           |
|----------------------------|------------------------------------------------------------------------------------------------------|
| **Dashboard Real-Time**    | Pantau status & progres proyek secara visual dan terintegrasi.                                       |
| **Input & Update Data**    | Mudah menambah/mutakhirkan data proyek melalui aplikasi.                                             |
| **Laporan Progres**        | Rekap harian/mingguan, ekspor ke PDF/Excel, dan bisa dishare ke stakeholder.                        |
| **Notifikasi & Reminder**  | Pengingat otomatis untuk deadline, update, dan milestone penting.                                   |
| **Manajemen User & Hak Akses** | Atur peran, hak akses, dan keamanan setiap pengguna.                                         |
| **Kolaborasi Tim**         | Fasilitas diskusi, komentar, dan update status antar anggota.                                        |
| **Integrasi Data**         | Semua data proyek terpusat, mudah diakses, dan siap digunakan kapan saja.                            |

---

## 🛠 **Teknologi & Tools**

| Komponen           | Stack/Tools                                |
|--------------------|--------------------------------------------|
| **Frontend**       | Flutter (Dart)                             |
| **Backend**        | (Opsional: Node.js, Express, atau Firebase)|
| **Database**       | (Opsional: PostgreSQL, Firestore, MySQL)   |
| **Version Control**| GitHub                                     |
| **Platform**       | Android, iOS                               |

---

## 🚀 **Langkah Instalasi**

### 1. Clone Repository

```bash
git clone https://github.com/rafdi03/APP_PLN.git
cd APP_PLN
```
### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run Aplikasi

```bash
flutter run
```

### 4. Struktur Direktori

```bash
APP_PLN/
├── frontend/           # Source code aplikasi Flutter
│   ├── lib/
│   ├── ios/
│   └── android/
├── backend/            # (Opsional) API, server, dsb
├── docs/               # Dokumentasi tambahan
└── README.md           # Dokumentasi utama
```

---

## 🏗️ **Contoh User Flow**

1. **Login**: User masuk menggunakan akun PLN.
2. **Akses Dashboard**: Melihat semua proyek aktif & statusnya.
3. **Input Data**: Menambahkan progres harian proyek.
4. **Pantau Notifikasi**: Mendapat pengingat deadline.
5. **Generate Laporan**: Ekspor laporan mingguan ke PDF.

---

## 🤝 **Kontribusi**

Kontribusi sangat terbuka 🎉:

1. **Fork** repo ini
2. Buat branch fitur (`git checkout -b fitur-anda`)
3. Commit perubahan & push
4. Buat Pull Request ke `main`
5. Diskusikan perubahan di PR

---

## 🧩 **Roadmap Fitur**

- [x] Dashboard Monitoring Proyek
- [x] Manajemen User & Hak Akses
- [ ] Integrasi Notifikasi via WhatsApp/Email
- [ ] Sinkronisasi Data dengan Sistem PLN Pusat
- [ ] Dark Mode dan Kustomisasi UI
- [ ] Export Data Proyek (PDF, Excel)
- [ ] Multi-language Support

---

## 📄 **Lisensi**

Belum ada lisensi resmi.  
Silakan buka [Issues](https://github.com/rafdi03/APP_PLN/issues) untuk berdiskusi mengenai lisensi.

---

## 📬 **Kontak**

- **GitHub**: [rafdi03](https://github.com/rafdi03) [Buitenzorx](https://github.com/Buitenzorx) 
- **Email**: aryagunayasa15@gmail.com

---

<div align="center">

> **APP_PLN** adalah fondasi digitalisasi manajemen proyek kelistrikan PLN Sumba, NTT.<br>
> Bersama kita wujudkan masa depan energi yang efisien, modern, dan transparan! ⚡️

</div>

---

<details>
  <summary><b>Credits & Thanks</b></summary>
  <ul>
    <li>PT. PLN (Persero) UIP Nusa Tenggara Timur</li>
    <li>Seluruh kontributor & pengguna</li>
  </ul>
</details>
