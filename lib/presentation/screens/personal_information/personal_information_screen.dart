import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';

import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_drop_down_widget.dart';

import 'widgets/info_text_field.dart';
import 'widgets/picture_section.dart';
import 'widgets/save_button_section.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyPersonalInformationScreen();
  }
}

class BodyPersonalInformationScreen extends StatelessWidget {
  const BodyPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "المعلومات الشخصية", showBackButton: true),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: AppPaddingHeight.p100,
                start: AppPaddingWidth.p20,
                end: AppPaddingWidth.p20,
              ),
              child: Column(
                spacing: AppHeight.h20,
                children: [
                  PictureSection(image: AppAssets.logo),
                  SizedBox(height: AppHeight.h1),
                  InfoTextField(
                    label: "الإسم الكامل",
                    icon: Iconsax.user_outline,
                    initValue: "سامي المرعي",
                    onChanged: (p0) {},
                  ),
                  InfoTextField(
                    label: "البريد الإلكتروني",
                    icon: Iconsax.sms_outline,
                    initValue: "wlcd@info.sy",
                    onChanged: (p0) {},
                  ),
                  InfoTextField(
                    label: "رقم الهاتف",
                    icon: Iconsax.call_outline,
                    initValue: "0938544444",
                    onChanged: (p0) {},
                  ),
                  // CustomDropDownWidget(
                  //   startPadding: AppPaddingWidth.p20,
                  //   onChanged: (value) {},
                  //   hintText: "السنة الدراسية",
                  //   items: ["ثانوي", "إعدادي", "إبتدائي"],
                  //   initialItem: "إعدادي",
                  //   borderRadius: AppRadius.r13,
                  //   isStringList: true,
                  // ),

                ],
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            child: SaveButtonSection(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
