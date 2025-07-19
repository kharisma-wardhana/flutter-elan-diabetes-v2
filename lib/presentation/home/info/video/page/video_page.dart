import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widget/base_page.dart';
import '../cubit/video_cubit.dart';
import '../cubit/video_state.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Video Edukasi'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.h,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state.videoState.status.isHasData &&
              state.videoState.data!.isEmpty) {
            return const Center(child: Text('Empty Data'));
          }
          if (state.videoState.status.isHasData) {
            return ListView(
              children: state.videoState.data!.map((e) {
                return ListTile(
                  title: Text(e.title),
                  onTap: () async {
                    await launchUrl(Uri.parse(e.url));
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                );
              }).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
