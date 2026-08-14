import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/helper/media_picker_helper.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';

class UploadAvatarCubit extends Cubit<UploadAvatarEntity> {
  UploadAvatarCubit() : super(const UploadAvatarEntity());

  Future<void> avatarChanged() async {
    final selectedImagePath = await MediaPickerHelper().pickImageFromGallery();
    if (selectedImagePath == null) return;

    emit(
      state.copyWith(
        file: [
          {'field_name': 'file', 'path': selectedImagePath},
        ],
      ),
    );
  }
}
