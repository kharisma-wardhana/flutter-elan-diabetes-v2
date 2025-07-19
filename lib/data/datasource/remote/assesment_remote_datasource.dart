import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../../domain/entities/activity/activity_entity.dart';
import '../../../domain/entities/antropometri_entity.dart';
import '../../../domain/entities/asam_urat_entity.dart';
import '../../../domain/entities/ginjal_entity.dart';
import '../../../domain/entities/gula_darah/gula_darah.dart';
import '../../../domain/entities/hb1ac_entity.dart';
import '../../../domain/entities/kolesterol_entity.dart';
import '../../../domain/entities/tensi_entity.dart';
import '../../../domain/entities/water_entity.dart';
import '../../model/activity/activity.dart';
import '../../model/asam_urat/asam_urat.dart';
import '../../model/assesment/antropometri.dart';
import '../../model/ginjal/ginjal.dart';
import '../../model/gula_darah/gula_darah.dart';
import '../../model/hb1ac/hb1ac.dart';
import '../../model/kolesterol/kolesterol.dart';
import '../../model/tekanan_darah/tekanan_darah.dart';
import '../../model/water/water.dart';

abstract class AssesmentRemoteDatasource {
  Future<Antropometri> addAntropometri(
    int userId,
    AntropometriEntity antropometri,
  );
  Future<Antropometri?> getDetailAntropometri(int userId);
  Future<List<Activity>> getListActivity(int userId, String date);
  Future<List<Activity>> addActivity(int userId, ActivityEntity activity);
  Future<List<Water>> getListWater(int userId, String date);
  Future<List<Water>> getGraphicWater(int userId, String month, String year);
  Future<List<Water>> addWater(int userId, WaterEntity water);
  Future<List<GulaDarah>> getListGulaDarah(int userId, String date);
  Future<List<GulaDarah>> getGraphicGulaDarah(
    int userId,
    String month,
    String year,
  );
  Future<List<GulaDarah>> addGulaDarah(int userId, GulaDarahEntity gula);
  Future<List<TekananDarah>> getListTekananDarah(int userId, String date);
  Future<List<TekananDarah>> getGraphicTekananDarah(
    int userId,
    String month,
    String year,
  );
  Future<List<TekananDarah>> addTekananDarah(int userId, TensiEntity tensi);
  Future<List<Kolesterol>> getListKolesterol(int userId, String date);
  Future<List<Kolesterol>> getGraphicKolesterol(
    int userId,
    String month,
    String year,
  );
  Future<List<Kolesterol>> addKolesterol(
    int userId,
    KolesterolEntity kolesterol,
  );
  Future<List<AsamUrat>> getListAsamUrat(int userId, String date);
  Future<List<AsamUrat>> getGraphicAsamUrat(
    int userId,
    String month,
    String year,
  );
  Future<List<AsamUrat>> addAsamUrat(int userId, AsamUratEntity asamUrat);
  Future<List<Hb1ac>> getListHb1ac(int userId, String date);
  Future<List<Hb1ac>> getGraphicHb1ac(int userId, String month, String year);
  Future<List<Hb1ac>> addHb1ac(int userId, Hb1acEntity hb1ac);
  Future<List<Ginjal>> getListGinjal(int userId, String date);
  Future<List<Ginjal>> getGraphicGinjal(int userId, String month, String year);
  Future<List<Ginjal>> addGinjal(int userId, GinjalEntity ginjal);
}

class AssesmentRemoteDatasourceImpl implements AssesmentRemoteDatasource {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;
  AssesmentRemoteDatasourceImpl({
    required this.apiService,
    required this.sharedPreferences,
  });

  @override
  Future<List<Water>> getListWater(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/waters?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Water.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Water>> addWater(int userId, WaterEntity water) async {
    try {
      final response = await apiService.postData('/users/$userId/waters', {
        'users_id': userId,
        'tanggal': water.date,
        'target': water.target,
        'jumlah': water.total,
      });
      final responseData = response.data as Map<String, dynamic>;
      sharedPreferences.setString('water', jsonEncode(responseData['list'][0]));
      return (responseData['list'] as List)
          .map((e) => Water.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Activity>> addActivity(
    int userId,
    ActivityEntity activity,
  ) async {
    try {
      final response = await apiService.postData('/users/$userId/activities', {
        'users_id': userId,
        'tanggal': activity.date,
        'jenis': activity.name,
        'jam': activity.hour,
        'menit': activity.minute,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Activity.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Activity>> getListActivity(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/activities?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Activity.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Antropometri> addAntropometri(
    int userId,
    AntropometriEntity antropometri,
  ) async {
    try {
      int statusInt = 0;
      if (antropometri.status == 'Obesitas') {
        statusInt = 2;
      }
      if (antropometri.status == 'Normal') {
        statusInt = 1;
      }
      final response = await apiService
          .postData('/users/$userId/anthropometrics', {
            'users_id': userId,
            'tinggi': antropometri.height,
            'berat': antropometri.weight,
            'hasil': antropometri.result,
            'lingkar_perut': antropometri.stomach,
            'lingkar_lengan': antropometri.hand,
            'jenis_aktivitas': antropometri.activity,
            'status': statusInt,
          });
      final responseData = response.data as Map<String, dynamic>;
      sharedPreferences.setString('antropometri', jsonEncode(responseData));
      return Antropometri.fromJson(responseData);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<AsamUrat>> getListAsamUrat(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/gouts?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => AsamUrat.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<GulaDarah>> getListGulaDarah(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/blood-sugars?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => GulaDarah.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Hb1ac>> getListHb1ac(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/hbs?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Hb1ac.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Kolesterol>> getListKolesterol(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/cholesterols?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Kolesterol.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<TekananDarah>> getListTekananDarah(
    int userId,
    String date,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/blood-pressures?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => TekananDarah.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Ginjal>> getListGinjal(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/kidneys?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Ginjal.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<AsamUrat>> addAsamUrat(
    int userId,
    AsamUratEntity asamUrat,
  ) async {
    try {
      final response = await apiService.postData('/users/$userId/gouts', {
        'users_id': userId,
        'tanggal': asamUrat.date,
        'jumlah': asamUrat.total,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => AsamUrat.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Ginjal>> addGinjal(int userId, GinjalEntity ginjal) async {
    try {
      final response = await apiService.postData('/users/$userId/kidneys', {
        'users_id': userId,
        'tanggal': ginjal.date,
        'type': ginjal.type,
        'jumlah': ginjal.total,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Ginjal.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<GulaDarah>> addGulaDarah(int userId, GulaDarahEntity gula) async {
    try {
      final response = await apiService
          .postData('/users/$userId/blood-sugars', {
            'users_id': userId,
            'tanggal': gula.date,
            'jam': gula.time,
            'type': gula.type,
            'kadar': gula.total,
          });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => GulaDarah.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Hb1ac>> addHb1ac(int userId, Hb1acEntity hb1ac) async {
    try {
      final response = await apiService.postData('/users/$userId/hbs', {
        'users_id': userId,
        'tanggal': hb1ac.date,
        'jumlah': hb1ac.total,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Hb1ac.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Kolesterol>> addKolesterol(
    int userId,
    KolesterolEntity kolesterol,
  ) async {
    try {
      final response = await apiService
          .postData('/users/$userId/cholesterols', {
            'users_id': userId,
            'tanggal': kolesterol.date,
            'type': kolesterol.type,
            'kadar_kolesterol': kolesterol.total,
          });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Kolesterol.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<TekananDarah>> addTekananDarah(
    int userId,
    TensiEntity tensi,
  ) async {
    try {
      final response = await apiService
          .postData('/users/$userId/blood-pressures', {
            'users_id': userId,
            'tanggal': tensi.date,
            'jam': tensi.time,
            'sistole': tensi.sistole,
            'diastole': tensi.diastole,
          });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => TekananDarah.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<AsamUrat>> getGraphicAsamUrat(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/gouts?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => AsamUrat.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Ginjal>> getGraphicGinjal(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/kidneys?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Ginjal.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<GulaDarah>> getGraphicGulaDarah(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/blood-sugars?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => GulaDarah.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Hb1ac>> getGraphicHb1ac(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/hbs?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Hb1ac.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Kolesterol>> getGraphicKolesterol(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/cholesterols?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Kolesterol.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<TekananDarah>> getGraphicTekananDarah(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/blood-pressures?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => TekananDarah.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Water>> getGraphicWater(
    int userId,
    String month,
    String year,
  ) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/waters?month=$month&year=$year',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Water.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Antropometri?> getDetailAntropometri(int userId) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/anthropometrics',
      );
      if (response.data == null) {
        return null;
      }
      final responseData = response.data as Map<String, dynamic>;
      return Antropometri.fromJson(responseData);
    } on ServerException {
      rethrow;
    }
  }
}
