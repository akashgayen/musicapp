import 'index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginPage(),
    );
  }
}
