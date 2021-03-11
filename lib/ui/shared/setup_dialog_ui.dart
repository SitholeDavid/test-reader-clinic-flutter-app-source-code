import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/locator.dart';
import 'package:test_reader_clinic_app/ui/constants/enums.dart';

void setupDialogUi() {
  final DialogService dialogService = locator<DialogService>();

  final builders = {
    DialogType.viewTestPicture: (context, sheetRequest, completer) =>
        _ViewTestPictureDialog(request: sheetRequest, completer: completer)
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _ViewTestPictureDialog extends StatelessWidget {
  final DialogRequest request;
  String imageUrl;
  final Function(DialogResponse) completer;

  _ViewTestPictureDialog({Key key, this.request, this.completer})
      : super(key: key) {
    this.imageUrl = request.title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      color: Colors.white70,
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => completer(null),
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child: Icon(Icons.close),
              ),
            ),
            Expanded(
                child: Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => SpinKitCircle(
                  color: Colors.grey,
                  size: 40,
                ),
                errorWidget: (context, url, error) => Text('No image to load'),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
