import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'profile_avatar_state.dart';

class ProfileAvatarCubit extends Cubit<ProfileAvatarState> {
  ProfileAvatarCubit() : super(const ProfileAvatarInitial());

  Future<void> upload(UploadAvatarEntity intent) async {
    emit(const ProfileAvatarUploading());
    final usecase = locator<
      IUseCase<BaseModel<ProfileModel>?, UploadAvatarEntity>
    >(instanceName: 'UploadAvatar');
    final result = await usecase(intent);
    result.fold(
      (failure) => emit(ProfileAvatarFailure(failure.message)),
      (response) => emit(ProfileAvatarUploaded(response?.data)),
    );
  }
}
