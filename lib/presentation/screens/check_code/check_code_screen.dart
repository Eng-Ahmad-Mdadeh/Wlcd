import 'package:go_router/go_router.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';
import 'package:wlcd/main.dart';
import 'package:wlcd/presentation/bloc/auth/check_code/check_code_bloc.dart';
import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/presentation/widgets/auth/logo_section.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'widgets/code_input_section.dart';
import 'widgets/phone_section.dart';
import 'widgets/resend_code_section.dart';

class CheckCodeScreen extends StatelessWidget {
  final String? redirects;

  const CheckCodeScreen({super.key, this.redirects});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckCodeBloc>(create: (context) => CheckCodeBloc()),
      ],
      child: BodyCheckCodeScreen(redirects: redirects),
    );
  }
}

class BodyCheckCodeScreen extends StatefulWidget {
  final String? redirects;

  const BodyCheckCodeScreen({super.key, this.redirects});

  @override
  State<BodyCheckCodeScreen> createState() => _BodyCheckCodeScreenState();
}

class _BodyCheckCodeScreenState extends State<BodyCheckCodeScreen> {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // FirebaseNotificationsHandler().warmUpFcmToken();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(showBackButton: true),
      body: BlocListener<CheckCodeBloc, ICheckCodeState>(
        listener: (context, state) async {
          if (state is CheckCodeLoading) {
            showDialog(
              context: context,
              builder: (context) => const PopScope(canPop: false, child: LoadingWidget(0)),
            );
          }
          if (state is CheckCodeLoaded) {
            context.pop();
            if (!state.authModel!.data!.user!.profileComplete!) {
              // CompleteProfileRoute().push(context);
            } else {
              if (context.mounted) {
                // HomeRoute().go(context);
              }
            }
          }
          if (state is CheckCodeFailed && context.mounted) {
            context.pop();
            showCustomSnackBar(
              context: context,
              title: "error",
              message: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is ResendCodeSuccess && context.mounted) {
            context.pop();
            context.read<CodeCheckCubit>().resetTime();
            showCustomSnackBar(
              context: context,
              title: context.loc.success,
              message: context.loc.code_sent,
              contentType: ContentType.success,
            );
          }
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: AppPaddingHeight.p65,
              start: AppPaddingWidth.p25,
              end: AppPaddingWidth.p25,
            ),
            child: Column(
              children: [
                const LogoSection(),
                const PhoneSection(),
                CodeInputSection(formKey: formKey, codeController: codeController),
                // wlcdSubmitButton(
                //   title: tr.continuation,
                //   marginTop: AppMarginHeight.m30,
                //   marginBottom: AppMarginHeight.m140,
                //   onPressed: () {
                //     LocateMeRoute().go(context);
                //   },
                // ),
                const ResendCodeSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
