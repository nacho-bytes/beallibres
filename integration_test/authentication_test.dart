import 'package:beallibres/app/models/models.dart' show User, UserData;
import 'package:beallibres/domain/domain.dart'
    show AuthenticationRepository, UsersRepository;
import 'package:beallibres/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' as auth
    show FirebaseAuth, User;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter_test/flutter_test.dart'
    show
        WidgetTester,
        contains,
        expect,
        fail,
        isNull,
        setUpAll,
        tearDown,
        testWidgets;
import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const String testUserEmail = 'testuser@local.test';
  const String testUserPassword = 'testpass123';
  const String testUserName = 'Test User';

  const String adminEmail = 'admin@local.test';
  const String adminPassword = 'adminpass123';

  late AuthenticationRepository authRepo;
  late UsersRepository usersRepo;

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await auth.FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

    usersRepo = UsersRepository();
    authRepo = AuthenticationRepository(usersRepository: usersRepo);
  });

  Future<void> cleanupTestUser() async {
    final User? currentUser = await authRepo.currentUser;
    if (currentUser != null) {
      await authRepo.logOut();
    }

    try {
      await authRepo.logInWithEmailAndPassword(
        email: testUserEmail,
        password: testUserPassword,
      );
    } catch (_) {}

    if (currentUser != null) {
      final String userId = currentUser.uid;

      await usersRepo.removeUserData(uid: userId);
      await authRepo.deleteCurrentUser();
    }
  }

  tearDown(() async {
    await cleanupTestUser();
    final User? currentUser = await authRepo.currentUser;
    if (currentUser != null) {
      await authRepo.logOut();
    }
  });

  testWidgets('Sign up, log in and log out', (final WidgetTester tester) async {
    const UserData userData = UserData(
      name: testUserName,
      isEnabled: true,
      isAdmin: false,
    );
    await authRepo.signUp(
      email: testUserEmail,
      password: testUserPassword,
      userData: userData,
    );
    final auth.User? currentUser = auth.FirebaseAuth.instance.currentUser;
    expect(currentUser?.email, testUserEmail);

    await authRepo.logOut();
    expect(auth.FirebaseAuth.instance.currentUser, isNull);

    await authRepo.logInWithEmailAndPassword(
      email: testUserEmail,
      password: testUserPassword,
    );
    expect(auth.FirebaseAuth.instance.currentUser?.email, testUserEmail);

    await authRepo.logOut();
    expect(auth.FirebaseAuth.instance.currentUser, isNull);
  });

  testWidgets('Login with existing admin user',
      (final WidgetTester tester) async {
    await authRepo.logInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    );
    expect(auth.FirebaseAuth.instance.currentUser?.email, adminEmail);

    await authRepo.logOut();
    expect(auth.FirebaseAuth.instance.currentUser, isNull);
  });

  testWidgets('Anonymous login and logout', (final WidgetTester tester) async {
    await authRepo.logInAnonymously();
    expect(auth.FirebaseAuth.instance.currentUser?.isAnonymous, true);

    await authRepo.logOut();
    expect(auth.FirebaseAuth.instance.currentUser, isNull);
  });

  testWidgets('Cannot sign up with already used email',
      (final WidgetTester tester) async {
    const UserData userData = UserData(
      name: testUserName,
      isEnabled: true,
      isAdmin: false,
    );
    await authRepo.signUp(
      email: testUserEmail,
      password: testUserPassword,
      userData: userData,
    );
    await authRepo.logOut();

    try {
      await authRepo.signUp(
        email: testUserEmail,
        password: testUserPassword,
        userData: userData,
      );
      fail('Should have thrown an exception for email already in use');
    } catch (e) {
      expect(e.toString(), contains('email-already-in-use'));
    }
  });

  testWidgets('Cannot log in with wrong password',
      (final WidgetTester tester) async {
    const UserData userData = UserData(
      name: testUserName,
      isEnabled: true,
      isAdmin: false,
    );
    await authRepo.signUp(
      email: testUserEmail,
      password: testUserPassword,
      userData: userData,
    );
    await authRepo.logOut();

    try {
      await authRepo.logInWithEmailAndPassword(
        email: testUserEmail,
        password: 'wrongpassword',
      );
      fail('Should have thrown an exception for wrong password');
    } catch (e) {
      expect(e.toString(), contains('wrong-password'));
    }
  });

  testWidgets('Cannot log in with non-existent user',
      (final WidgetTester tester) async {
    try {
      await authRepo.logInWithEmailAndPassword(
        email: 'nouser@local.test',
        password: 'somepassword',
      );
      fail('Should have thrown an exception for user not found');
    } catch (e) {
      expect(e.toString(), contains('user-not-found'));
    }
  });
}
