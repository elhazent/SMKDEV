class BaseFunction{
  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
  static shortMonthName(int val, {bool short = true}) {
    if(val == 1) return short ? 'Jan' : 'Januari';
    if(val == 2) return short ? 'Feb' : 'Februari';
    if(val == 3) return short ? 'Mar' : 'Maret';
    if(val == 4) return short ? 'Apr' : 'April';
    if(val == 5) return short ? 'Mei' : 'Mei';
    if(val == 6) return short ? 'Jun' : 'Juni';
    if(val == 7) return short ? 'Jul' : 'Juli';
    if(val == 8) return short ? 'Ags' : 'Agustus';
    if(val == 9) return short ? 'Sep' : 'September';
    if(val == 10) return short ? 'Okt' : 'Oktober';
    if(val == 11) return short ? 'Nov' : 'November';
    if(val == 12) return short ? 'Des' : 'Desember';
  }

  static milliToShortDate(int millisec) {
    if(millisec ==0 || millisec ==null) return "Tanggal tidak tersedia";
    DateTime src = DateTime.fromMillisecondsSinceEpoch(millisec);
    var year = src.year; var mon = shortMonthName(src.month); var day = src.day;
    return '$day $mon $year';
  }

  static milliToShortDateTanggal(int millisec) {
    if(millisec ==0 || millisec ==null) return "Tanggal tidak tersedia";
    DateTime src = DateTime.fromMillisecondsSinceEpoch(millisec);
    var year = src.year; var mon = shortMonthName(src.month); var day = src.day;
    return '$day';
  }
  static milliToShortDateBulan(int millisec) {
    if(millisec ==0 || millisec ==null) return "Tanggal tidak tersedia";
    DateTime src = DateTime.fromMillisecondsSinceEpoch(millisec);
    var year = src.year; var mon = shortMonthName(src.month); var day = src.day;
    return '$mon';
  }

  static milliToLongDate(int millisec) {
    if(millisec ==0) return "Tanggal tidak tersedia";
    DateTime src = DateTime.fromMillisecondsSinceEpoch(millisec);
    var year = src.year; var mon = shortMonthName(src.month,short: false); var day = src.day;
    return '$day $mon $year';
  }

  static milliToShortTime(int millisec) {
    if(millisec ==0) return "Jam tidak tersedia";
    DateTime src = DateTime.fromMillisecondsSinceEpoch(millisec);
    var hour = src.hour; var mint = src.minute;
    var newmin = "${mint}";
    if (mint < 10){
      newmin = "0${mint}";
    }
    return '$hour:$newmin';
  }

}