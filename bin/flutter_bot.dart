import 'package:nyxx/nyxx.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'flutter_search.dart';

void main(List<String> arguments) {
  dotenv.load();

  final bot = Nyxx(
    dotenv.env['DISCORD_TOKEN']!,
    GatewayIntents.allUnprivileged,
  );

  bot.onReady.listen((event) {
    print('${bot.self.username} has connected to Discord!');
  });

  bot.onMessageReceived.listen((event) {
    if (event.message.author.id == bot.self.id) return;
    if (event.message.content.startsWith('basta ler')) {
      search(event.message.content).then(
        (value) => value?.forEach(
          (element) => event.message.channel.sendMessage(
            MessageBuilder.embed(
              EmbedBuilder()
                ..title = element.title
                ..description = element.description
                ..url = element.url,
            ),
          ),
        ),
      );
    }
  });
}
