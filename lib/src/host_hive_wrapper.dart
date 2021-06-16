import 'box_wrapper.dart';

abstract class HostHiveWrapper {
  late List<BoxWrapper> boxs;

  Future<void> loadHive() async {}
}
