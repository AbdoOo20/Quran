import 'package:flutter/material.dart';
import 'package:quran/models/juz.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/style.dart';
import 'package:quran/widgets/juz_custom_tile.dart';

class JuzScreen extends StatelessWidget {
  int? index;

  ApiServices api = ApiServices();

  JuzScreen(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(index.toString() + ' الجَزْء'),
            centerTitle: true),
        body: FutureBuilder<JuzModel>(
          future: api.getJuz(Constants.juzIndex!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active ||
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.juzAyahs.length,
                itemBuilder: (context, index) {
                  return juzCustomTile(
                    list: snapshot.data!.juzAyahs,
                    index: index,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
