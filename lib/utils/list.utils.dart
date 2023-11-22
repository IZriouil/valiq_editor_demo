class ListUtils {
  static int getCurrentIndexFromList(List<double> list, double offset) {
    double width = 0;
    for (int i = 1; i <= list.length; i++) {
      width += list[i - 1];
      if (offset == width) {
        return i - 1;
      }
    }
    return 0;
  }
}
