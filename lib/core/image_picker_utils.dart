import 'package:image_picker/image_picker.dart';

abstract class ImagePickerUtils {
  Future<String> selectImageFromGallery();
}

class ImagePickerUtilsImpl extends ImagePickerUtils {
  @override
  Future<String> selectImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image != null) {
        return image.path;
      } else {
        return '';
      }
    } catch (ex) {
      return '';
    }
  }
}
