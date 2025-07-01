class Exceptions {
  static String getFriendlyErrorMessage(String error) {
    final String lowercasedError = error.toLowerCase();

    if (lowercasedError.contains('socketexception') ||
        lowercasedError.contains('failed host lookup')) {
      return 'Tidak ada koneksi internet. Silakan periksa jaringan Anda.';
    } else if (lowercasedError.contains('connection timed out')) {
      return 'Koneksi ke server terputus. Silakan coba lagi.';
    } else if (lowercasedError.contains('handshakeexception')) {
      return 'Koneksi tidak aman. Silakan periksa pengaturan jaringan Anda.';
    } else if (lowercasedError.contains('platformexception')) {
      return 'Terjadi kesalahan pada platform. Silakan mulai ulang aplikasi.';
    } else if (lowercasedError.contains('invalid credentials') ||
        lowercasedError.contains('user not found')) {
      return 'ID atau kata sandi salah. Silakan coba lagi.';
    } else if (lowercasedError.contains('http status error 404')) {
      return 'Layanan tidak ditemukan. Silakan hubungi administrator.';
    } else if (lowercasedError.contains('http status error 500')) {
      return 'Terjadi masalah pada server. Silakan coba lagi nanti.';
    } else {
      return 'Terjadi kesalahan yang tidak diketahui. Silakan coba lagi.';
    }
  }
}
