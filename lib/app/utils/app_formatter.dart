import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:japbusi/app/utils/app_colors.dart';

class AppFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  // format date time
  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMMM yyyy HH:mm').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(amount);
  }

  static String formatStatus(int status) {
    switch (status) {
      case 0:
        return 'Proses';
      case 1:
        return 'Selesai';
      case 2:
        return 'Arsip';
      case 3:
        return 'DiLimpahkan';
      case 4:
        return 'Belum Terdaftar';
      default:
        return 'Belum Terdaftar';
    }
  }

  static String formatStep(int step) {
    switch (step) {
      case 0:
        return 'Menunggu Verifikasi';
      case 1:
        return 'Proses Verifikasi dan Investigasi Awal';
      case 2:
        return 'Non Litigasi';
      case 3:
        return 'Litigasi';
      case 4:
        return 'Non Litigasi';
      default:
        return 'PHI';
    }
  }

  static FaIcon getStepIcon(int step) {
    switch (step) {
      case 0:
        return FaIcon(
          FontAwesomeIcons.hourglassHalf,
          color: AppColors.stepColors[0],
          size: 12,
        );
      case 1:
        return FaIcon(
          FontAwesomeIcons.circleCheck,
          color: AppColors.stepColors[1],
          size: 12,
        );
      case 2:
        return FaIcon(
          FontAwesomeIcons.gavel,
          color: AppColors.stepColors[2],
          size: 12,
        );
      case 3:
        return FaIcon(
          FontAwesomeIcons.scaleUnbalancedFlip,
          color: AppColors.stepColors[3],
          size: 12,
        );
      default:
        return FaIcon(
          FontAwesomeIcons.scaleUnbalancedFlip,
          color: AppColors.stepColors[4],
          size: 12,
        );
    }
  }
}
