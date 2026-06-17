import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  /// Format amount as currency (₹1,234.56)
  /// Input in paisa, output in rupees
  static String currency(num paisa, {bool showSymbol = true}) {
    final rupees = paisa / 100;
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: showSymbol ? '₹' : '',
      decimalDigits: 2,
    );
    return formatter.format(rupees);
  }

  /// Format amount without paisa (₹1,234)
  static String currencyWhole(num paisa) {
    final rupees = paisa ~/ 100;
    final formatter = NumberFormat('#,##,###', 'en_IN');
    return '₹${formatter.format(rupees)}';
  }

  /// Compact format (₹1.2K, ₹1.5L)
  static String currencyCompact(num paisa) {
    final rupees = paisa / 100;
    if (rupees >= 10000000) {
      return '₹${(rupees / 10000000).toStringAsFixed(1)}Cr';
    } else if (rupees >= 100000) {
      return '₹${(rupees / 100000).toStringAsFixed(1)}L';
    } else if (rupees >= 1000) {
      return '₹${(rupees / 1000).toStringAsFixed(1)}K';
    }
    return '₹${rupees.toStringAsFixed(0)}';
  }

  /// Format mobile number (+91 98765 43210)
  static String mobile(String mobile) {
    if (mobile.length == 10) {
      return '+91 ${mobile.substring(0, 5)} ${mobile.substring(5)}';
    }
    return mobile;
  }

  /// Mask mobile (+91 *****43210)
  static String mobileMasked(String mobile) {
    if (mobile.length == 10) {
      return '+91 *****${mobile.substring(5)}';
    }
    return mobile;
  }

  /// Mask Aadhaar (XXXX-XXXX-1234)
  static String aadhaarMasked(String aadhaar) {
    if (aadhaar.length == 12) {
      return 'XXXX-XXXX-${aadhaar.substring(8)}';
    }
    return aadhaar;
  }

  /// Mask account number (XXXXXX1234)
  static String accountMasked(String accNo) {
    if (accNo.length >= 4) {
      return '${'X' * (accNo.length - 4)}${accNo.substring(accNo.length - 4)}';
    }
    return accNo;
  }

  /// Date format (12 Jun 2026)
  static String date(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Date with time (12 Jun 2026, 10:30 AM)
  static String dateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  /// Relative time (2 hours ago, just now)
  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${diff.inDays ~/ 7}w ago';
    if (diff.inDays < 365) return '${diff.inDays ~/ 30}mo ago';
    return '${diff.inDays ~/ 365}y ago';
  }
}