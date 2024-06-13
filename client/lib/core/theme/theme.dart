import 'package:client/index.dart';

class AppTheme {
  static OutlineInputBorder _border(
          [Color borderColor = Pallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      focusedBorder: _border(Pallete.gradient2),
      enabledBorder: _border(),
    ),
  );
}
