
//영화 진흥원 박스 오피스
class BoxOffice {
  final String showRange;
  final String rank;
  final String movieNm;

  BoxOffice({
    required this.showRange,
    required this.rank,
    required this.movieNm,
  });

  factory BoxOffice.fromJson(Map<String, dynamic> json){
    return BoxOffice(
        showRange: json['showRange'],
        rank: json['rank'],
        movieNm: json['movieNm']);
  }
}


