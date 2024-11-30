# beallibres

Plataforma de gestió de la biblioteca de llibres del [Bloc de l'Estudiantat Agermanat](www.beapv.info).

L'aplicació consisteix en un frontend que permet als usuaris de la biblioteca consultar el catàleg de llibres disponibles, reservar-los i rebre notificacions de la seua disponibilitat. A més, els administradors poden gestionar el catàleg, els usuaris i les reserves.

## Instal·lació

Aquesta aplicació ha sigut dessenvolupada en [Flutter](https://flutter.dev/), un framework de Google per a la creació d'aplicacions mòbils multiplataforma. Per al backend es fa servir [Firebase](https://firebase.google.com/), un conjunt de serveis de Google per a la creació d'aplicacions web i mòbils. Per a instal·lar l'aplicació, cal seguir els següents passos:

1. Clonar el repositori:

```bash
git clone https://github.com/nacho-bytes/beallibres.git
```

2. Entrar al directori del projecte:

```bash
cd beallibres
```

3. Verifica que tingues instal·lats els següents requeriments:

  - [Firebase CLI](https://firebase.google.com/docs/cli?hl=en&authuser=2#install_the_firebase_cli) i iniciar sessió (amb `firebase login`).
  - [Flutter SDK](https://docs.flutter.dev/get-started/install) i verifica que estigui configurat correctament amb `flutter doctor`.
  - Activa el plugin de FlutterFire amb `dart pub global activate flutterfire_cli`.

4. Instal·lar les dependències:

```bash
flutter pub get
```

5. Al directori arrel del teu projecte Flutter, executa aquesta comanda:

```bash
flutterfire configure --project=beallibres
```

6. Compilar l'aplicació:

```bash
flutter run
```
