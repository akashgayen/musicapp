import 'package:client/index.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    return const Scaffold();
  }
}
