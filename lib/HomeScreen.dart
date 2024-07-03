import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BoxOffice.dart';
import 'RequestAPI.dart';

class HomeScreen extends StatelessWidget {

  final Future<List<BoxOffice>> boxOffice = RequestAPI.getTodaysBoxOffice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: boxOffice,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return makeGrid(snapshot);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  GridView makeGrid(AsyncSnapshot<List<BoxOffice>> snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movieList = snapshot.data![index];
        return Container(
            child: Text(movieList.movieNm)
        );
      },

    );
  }

}