import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/image_compress_util.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class ChangeProfileImage extends StatefulWidget {
  final Function (String base64Image) onImageSelect;

  ChangeProfileImage({@required this.onImageSelect});

  @override
  _ChangeProfileImageState createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  File fileProfileImage;
  bool isBusyImageCrop = false;

  String getBase64Image() {
    List<int> imageBytes = fileProfileImage.readAsBytesSync();
//    print(imageBytes);
    var img = "data:image/jpg;base64," + base64Encode(imageBytes);

//    print(img);
    return img;
  }

  Future getImage() async {
    PickedFile _file =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (_file != null) {
//      var compressedImage =
//          await ImageCompressUtil.compressImage(File(_file.path), 40);
      ImageCropper.cropImage(
          sourcePath: _file.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
//            CropAspectRatioPreset.ratio3x2,
//            CropAspectRatioPreset.original,
//            CropAspectRatioPreset.ratio4x3,
//            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )).then((value) {
            fileProfileImage = value;
            widget.onImageSelect( getBase64Image());
            if(this.mounted)
            setState(() {

            });
      });

    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var companyVm = Provider.of<CompanyProfileViewModel>(context);
    var primaryColor = Theme.of(context).primaryColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                width: 180,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: fileProfileImage != null
                          ? Image.file(
                              fileProfileImage,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              placeholder: (context, _) => Image.asset(
                                kDefaultUserImageAsset,
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                              imageUrl:
                                  companyVm?.company?.profilePicture ?? "",
                            ),
                    )),
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 4),
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: Icon(
                    FontAwesomeIcons.pencilAlt,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
              ),
              right: 0,
              bottom: 0,
            ),
            isBusyImageCrop
                ? Positioned(
                    bottom: 80,
                    left: 80,
                    child: Loader(),
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }
}
