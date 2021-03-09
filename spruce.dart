import 'dart:io';

void main(List<String> args) async {
    if (args.length == 0) {
        print('Error: Spruce needs program to execute.');
        return;
    }

    final result = await Process.run('dart', ['run', args[0]]);
    final server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 80);

    await for (var request in server) {
        request.response
            ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
            ..write(result.stdout)
            ..close();
    }
}
