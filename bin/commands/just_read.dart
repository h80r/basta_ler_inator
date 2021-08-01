import 'package:nyxx/nyxx.dart';

import '../utils/flutter_search.dart';

void justRead(Message msg) async {
  final channel = msg.channel;

  await search(msg.content).then(
    (value) {
      channel.startTypingLoop();

      value?.forEach(
        (element) => channel.sendMessage(
          MessageBuilder.embed(
            EmbedBuilder()
              ..title = element.title
              ..description = element.description
              ..url = element.url,
          ),
        ),
      );

      channel.stopTypingLoop();
    },
  );
}
