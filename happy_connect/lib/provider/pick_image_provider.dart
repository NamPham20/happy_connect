import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = StateNotifierProvider<ImagePickerNotifier,XFile?>((ref) {
  return ImagePickerNotifier();
});

class ImagePickerNotifier extends StateNotifier<XFile?> {

  ImagePickerNotifier() : super(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = pickedFile;
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear
    );

    if (pickedFile != null) {
      state = pickedFile;
    }
  }
}
