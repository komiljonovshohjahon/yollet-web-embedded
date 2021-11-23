class SidebarModel {
  String name;
  String route;
  int selectedNumber;
  int parentNumber;

  SidebarModel(
      {required this.name,
      required this.route,
      this.selectedNumber = -1,
      required this.parentNumber});
}
