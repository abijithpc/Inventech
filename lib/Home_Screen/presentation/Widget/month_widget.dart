  String monthLabel(String date) {
    final parts = date.split('-');
    final monthNum = int.parse(parts[1]);
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${monthNames[monthNum - 1]} '${parts[0].substring(2)}";
  }