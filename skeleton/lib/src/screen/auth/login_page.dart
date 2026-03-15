import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base/widget/base_statefull_widget.dart';
import '../../bloc/auth/login_cubit.dart';
import '../../common/app_localizations.dart';
import '../../common/dimens.dart';
import '../../common/image_constant.dart';
import '../../theme/colors_theme.dart';
import '../../widgets/input_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginPage extends BaseStatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseStatefulWidgetState<LoginCubit, LoginPage> {
  final TextEditingController _userCodeTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final ValueNotifier<bool> _checkBoxNotifier = ValueNotifier<bool>(false);

  ThemeData get theme => Theme.of(context);

  TextStyle? get titleTextStyle =>
      theme.textTheme.titleSmall?.copyWith(color: AppColors.deepPurple);
  TextStyle? get inputTextStyle =>
      theme.textTheme.bodyMedium?.copyWith(color: AppColors.deepPurple);
  TextStyle? get infoTextStyle => theme.textTheme.titleLarge
      ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w400);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _checkBoxNotifier.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ceriseColor,
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(top: Dimens.size80, bottom: Dimens.size30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  ImageConstants.imgLogo,
                  fit: BoxFit.none,
                )),
              ],
            ),
          ),
        ),
        Container(
          width: Dimens.size329,
          height: Dimens.size366,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(
                  height: Dimens.size24,
                ),
                Text(context.tr('login.greeting'), style: titleTextStyle),
                const SizedBox(
                  height: Dimens.size12,
                ),
                SizedBox(
                  height: Dimens.size60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: InputTextField(
                      controller: _userCodeTextController,
                      hintText: tr('login.username_hint'),
                      textStyle: inputTextStyle,
                      hintStyle: inputTextStyle,
                      onChanged: (value) {
                        final trimVal = value.trim();
                        if (value != trimVal) {
                          setState(() {
                            _userCodeTextController.text = trimVal;
                            _userCodeTextController.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: trimVal.length),
                            );
                          });
                        }
                      },
                      validator: (value) {
                        if (StringUtils.isNullOrEmpty(value)) {
                          return 'error';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.size50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: InputTextField(
                      controller: _passwordTextController,
                      hintText: tr('login.password'),
                      hintStyle: inputTextStyle,
                      textStyle: inputTextStyle,
                      isPassword: true,
                      validator: (value) {
                        if (StringUtils.isNullOrEmpty(value)) {
                          return 'error';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimens.size12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _checkBoxNotifier,
                        builder: (_, value, _) {
                          return SizedBox(
                            height: Dimens.size16,
                            width: Dimens.size16,
                            child: Checkbox(
                              activeColor: AppColors.lightPurple,
                              side: const BorderSide(
                                color: AppColors.deepPurple,
                                width: Dimens.size1,
                              ),
                              onChanged: (value) {
                                _checkBoxNotifier.value = value ?? false;
                              },
                              value: value,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: Dimens.size10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Dimens.size4),
                        child: Text(
                          tr('login.remember_password'),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.deepPurple),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimens.size36,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size24),
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      return CustomButton(
                        width: double.infinity,
                        label: tr('login.login'),
                        isLoading: false,
                        selected: true,
                        onTap: () {
                          bloc.onLogin(_userCodeTextController.text.trim(),
                              _passwordTextController.text.trim(), true);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: Dimens.size24,
                ),
                Text(
                  tr('login.forgot_password'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.deepPurple),
                )
              ]),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimens.size33),
            child: Column(children: [
              Text(
                'Hỗ trợ kĩ thuật: 1800xxxx',
                style: infoTextStyle,
              ),
              Text(
                'Version: 1.1.0',
                style: infoTextStyle,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
