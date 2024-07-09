import 'package:client/index.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: Colors.white,
      size: 20,
    );
  }
}