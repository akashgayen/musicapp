import 'package:client/index.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            7,
          ),
          gradient: const LinearGradient(
            colors: [
              Pallete.gradient1,
              Pallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(100.w, 60),
            backgroundColor: Pallete.transparentColor,
            shadowColor: Pallete.transparentColor,
          ),
          onPressed: onTap,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Pallete.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
