import 'dart:io';

import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomEmojiWidget extends StatelessWidget {
  const CustomEmojiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      textEditingController: context.read<HomeService>().messageController,
      config: Config(
        height: SizeConfig.screenHeight * 0.4,
        checkPlatformCompatibility: false,
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax: 28 * (Platform.isIOS ? 1.20 : 1.0),
          columns: 7,
        ),
      ),
    );
  }
}
