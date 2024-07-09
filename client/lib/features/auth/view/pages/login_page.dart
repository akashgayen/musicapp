import 'package:client/index.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select(
        (val) => val?.isLoading == true,
      ),
    );
    ref.listen(authViewModelProvider, (_, curr) {
      curr?.when(
        data: (data) {
          showSnackBar(
            context: context,
            message: 'Sign in successful!',
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (_) => false,
          );
        },
        error: (error, st) {
          showSnackBar(
            context: context,
            message: error.toString(),
          );
        },
        loading: () {},
      );
    });
    return ResponsiveSizer(
      builder: (p0, p1, p2) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomField(
                  hintText: 'Password',
                  controller: passwordController,
                  obscure: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthGradientButton(
                  isLoading: isLoading,
                  buttonText: 'Sign In',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await ref.read(authViewModelProvider.notifier).loginUser(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    } else {
                      showSnackBar(
                          context: context, message: 'Missing fields!');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPage(),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 16.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Pallete.gradient1,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
