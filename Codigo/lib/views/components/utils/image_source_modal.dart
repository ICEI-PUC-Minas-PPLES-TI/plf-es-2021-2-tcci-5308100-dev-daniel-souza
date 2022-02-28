import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal({Key? key, required this.onImageSelected})
      : super(key: key);

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        builder: ((_) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: getImageFromCamera,
                  child: const Text('Câmera'),
                ),
                TextButton(
                  onPressed: getImageFromGallery,
                  child: const Text('Galeria'),
                ),
              ],
            )),
        onClosing: () {},
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o anúncio'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getImageFromCamera,
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: getImageFromGallery,
            child: const Text('Galeria'),
          ),
        ],
      );
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      imageSelected(image);
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      imageSelected(image);
    }
  }

  Future<void> imageSelected(File image) async {
    final File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Editar imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Editar imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );
    if (croppedFile != null) {
      onImageSelected(croppedFile);
    }
  }
}
