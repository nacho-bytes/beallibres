import 'package:integration_test/integration_test.dart'
    show IntegrationTestWidgetsFlutterBinding;

import 'authentication_test.dart' as authentication;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  authentication.main();
}
