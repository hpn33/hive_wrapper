BASEDIR=$(dirname "$0")

cd $BASEDIR/../packages/hive_wrapper

echo "Installing hive_wrapper"
dart pub get

cd ../hive_wrapper_generator

echo "overriding hive_wrapper dependencies"
echo "
dependency_overrides:
  hive_wrapper:
    path: ../hive_wrapper" >> pubspec.yaml

echo "Installing hive_wrapper_generator"
dart pub get
