/// Decorates a function to customize the generated class
class BoxWrapper {
  const BoxWrapper({
    this.boxName = '',
    this.boxType = dynamic,
  });

  final String boxName;

  // List<HiveMigration> migrations = [];

  final Type boxType;
}

const BoxWrapper boxWrapper = BoxWrapper();
