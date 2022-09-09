String shortenDayList(List<String> days) {
  return days.map((e) => e.substring(0, 2)).join(', ');
}
