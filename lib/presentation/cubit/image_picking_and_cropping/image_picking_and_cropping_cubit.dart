// import 'dart:io';
//
// import 'package:croppy/croppy.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickingAndCroppingCubit extends Cubit<CropImageResult?> {
//   ImagePickingAndCroppingCubit() : super(null);
//
//   Future<void> pickImage(BuildContext context) async {
//     final result = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (result != null) {
//       final path = result.path;
//       if (context.mounted) {
//         final imageProvider = FileImage(File(path)) as ImageProvider;
//         showMaterialImageCropper(
//           context,
//           imageProvider: imageProvider,
//           postProcessFn: (result) async {
//             emit(result);
//             return result;
//           },
//         );
//       }
//     }
//   }
// }
