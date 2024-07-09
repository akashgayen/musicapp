import 'package:client/index.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
        data: (data) async {
          showSnackBar(
            context: context,
            message: 'Sign up successful!',
          );
          await ref.read(authViewModelProvider.notifier).loginUser(
                email: emailController.text,
                password: passwordController.text,);
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 10,
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
                  buttonText: 'Sign Up',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await ref.read(authViewModelProvider.notifier).signUpUser(
                            name: nameController.text,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Pallete.whiteColor,
                        fontSize: 16.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
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
