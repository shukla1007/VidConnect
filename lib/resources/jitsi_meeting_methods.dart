import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:vidConnect/resources/auth_methods.dart';
import 'package:vidConnect/resources/firestore_methods.dart';

class JitsiMeetingMethod {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    final AuthMethods authMethods = AuthMethods();
    final jitsiMeetPlugin = JitsiMeet();

    String name;
    if (username.isEmpty) {
      name = authMethods.user.displayName!;
    } else {
      name = username;
    }

    var options = JitsiMeetConferenceOptions(
      room: roomName,
      configOverrides: {
        "startWithAudioMuted": isAudioMuted,
        "startWithVideoMuted": isVideoMuted,
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "ios.screensharing.enabled": true
      },
      userInfo: JitsiMeetUserInfo(
        displayName: name,
        email: authMethods.user.email,
        avatar: authMethods.user.photoURL,
      ),
    );

    _firestoreMethods.addToMeetingHistory(roomName);
    await jitsiMeetPlugin.join(
      options,
    );
  }
}
