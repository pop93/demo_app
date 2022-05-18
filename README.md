# README #
This README would normally document whatever steps are necessary to get your application up and running.

# App desc #
Fetch data from api and view in table with load more functionality.

### First build? ###
flutter pub get

### Json serialization and database models? ###
flutter packages pub run build_runner build --delete-conflicting-outputs

### Build apk for android - dev env? ###
flutter build apk --flavor dev -t lib/main/main_dev.dart

### flavour
entry point main_<...>
flavor (dev,stag,prod)

### Flutter version checkout? ###
$ cd flutter
$ # git checkout [branch, tag or commit hash]
$ git checkout v1.22.6       //example
