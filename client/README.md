# client

A new Flutter project.

- Génér les variables d'environnement

```sh
dart run build_runner build
```

- Compiler les fichiers de traduction

Créer le dossier `assets/translations` et ajouter les fichiers de traduction.

```sh
flutter pub run easy_localization:generate -S assets/translations 
```

```sh
flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
```