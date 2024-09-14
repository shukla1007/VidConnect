import 'package:flutter/material.dart';
import 'package:vidConnect/resources/auth_methods.dart';
import 'package:vidConnect/resources/jitsi_meeting_methods.dart';
import 'package:vidConnect/utils/colors.dart';
import 'package:vidConnect/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  AuthMethods authMethods = AuthMethods();
  JitsiMeetingMethod jitsiMeetingMethod = JitsiMeetingMethod();

  late TextEditingController meetingIdController;
  late TextEditingController meetingNameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    meetingNameController =
        TextEditingController(text: authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    meetingNameController.dispose();
  }

  _joinMeeting() {
    jitsiMeetingMethod.createMeeting(
        roomName: meetingIdController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting!',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room ID',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingNameController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Join',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
              text: 'Mute Audio',
              isMuted: isAudioMuted,
              onChanged: onToggleAudio),
          MeetingOption(
              text: 'Turn Off My Video',
              isMuted: isVideoMuted,
              onChanged: onToggleVideo),
        ],
      ),
    );
  }

  onToggleAudio(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onToggleVideo(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
