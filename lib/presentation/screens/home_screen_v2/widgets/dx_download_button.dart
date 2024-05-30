import 'package:downloader/core/core.dart';
import 'package:flutter/material.dart';

class DxDownloadButton extends StatelessWidget {
  const DxDownloadButton({super.key, required this.onClick});
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: DxLightScheme().getPrimaryColor(),
            border: Border.all(
              color: DxLightScheme().getBackgroundColor(),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: DxLightScheme().getBackgroundColor(),
                offset: const Offset(.1, .2),
                blurRadius: 2.0,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Go',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: DxLightScheme().getBackgroundColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
