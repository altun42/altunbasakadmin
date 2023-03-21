import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final String aciklama;
  final String adress;
  final String aidat;
  final String banyoSayisi;
  final String binadakiKatSayisi;
  final String binaninYasi;
  final String il;
  final String ilce;
  final String bulunduguKat;
  final String cepheSecenekleri;
  final String fiyat;
  final String ilanBasligi;
  final String ilanNo;
  final String ilanTarihi;
  final String ilanTipi;
  final String isinmaTipi;
  final String kiraGetirisi;
  final String konutSekli;
  final String krediyeUygunluk;
  final String kullanimDurumu;
  final String metreKare;
  final String odaSayisi;
  final String siteIcerisinde;
  final String takas;
  final String yakitTipi;
  final String yapiTipi;
  final String yapininDurumu;

  Data(
      {required this.aciklama,
      required this.adress,
      required this.aidat,
      required this.banyoSayisi,
      required this.binaninYasi,
      required this.bulunduguKat,
      required this.cepheSecenekleri,
      required this.fiyat,
      required this.il,
      required this.ilanBasligi,
      required this.ilanNo,
      required this.ilanTarihi,
      required this.ilanTipi,
      required this.ilce,
      required this.isinmaTipi,
      required this.kiraGetirisi,
      required this.konutSekli,
      required this.krediyeUygunluk,
      required this.kullanimDurumu,
      required this.metreKare,
      required this.odaSayisi,
      required this.siteIcerisinde,
      required this.takas,
      required this.yakitTipi,
      required this.yapiTipi,
      required this.yapininDurumu,
      required this.binadakiKatSayisi});

  factory Data.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Data(
      aciklama: data["aciklama"],
      adress: data['adress'] ?? '',
      aidat: data['aidat'] ?? '',
      banyoSayisi: data['banyoSayisi'] ?? '',
      binadakiKatSayisi: data['binadakiKatSayisi'] ?? '',
      binaninYasi: data['binaninYasi'] ?? '',
      bulunduguKat: data['bulunduguKat'] ?? '',
      cepheSecenekleri: data['cepheSecenekleri'] ?? '',
      fiyat: data['fiyat'] ?? '',
      il: data['il'] ?? '',
      ilanBasligi: data['ilanBasligi'] ?? '',
      ilanNo: data['ilanNo'] ?? '',
      ilanTarihi: data['ilanTarihi'] ?? '',
      ilanTipi: data['ilanTipi'] ?? '',
      ilce: data['ilce'] ?? '',
      isinmaTipi: data['isinmaTipi'] ?? '',
      kiraGetirisi: data['kiraGetirisi'] ?? '',
      konutSekli: data['konutSekli'] ?? '',
      krediyeUygunluk: data['krediyeUygunluk'] ?? '',
      kullanimDurumu: data['kullanimDurumu'] ?? '',
      metreKare: data['metreKare'] ?? '',
      odaSayisi: data['odaSayisi'] ?? '',
      siteIcerisinde: data['siteIcerisinde'] ?? '',
      takas: data['takas'] ?? '',
      yakitTipi: data['yakitTipi'] ?? '',
      yapiTipi: data['yapiTipi'] ?? '',
      yapininDurumu: data['yapininDurumu'] ?? '',
    );
  }
}
