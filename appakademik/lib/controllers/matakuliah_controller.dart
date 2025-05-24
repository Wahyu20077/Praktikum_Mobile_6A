import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appakademik/models/mata_kuliah.dart';
import '../controllers/matakuliah_controller.dart';

class ApiService {
  // final String baseUrl = "http://localhost:8000/api/mata-kuliah";
  // final String baseUrl = 'http://10.0.2.2:8000/api/mahasiswa';
  //final String baseUrl = 'http://192.168.168.64:8000/api/mata_kuliahs';
  //final String baseUrl = 'http://192.168.1.5:8000/api/mata_kuliahs';
  //final String baseUrl = 'http://10.12.1.9:8000/api/mata_kuliahs';
  final String baseUrl = 'http://10.12.1.9:8000/api/mata_kuliahs';
  
  
  Future<List<MataKuliah>> fetchMataKuliah() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => MataKuliah.fromJson(data)).toList();
    } else {
      throw Exception('Gagal untuk load mata kuliah');
    }
  }

  Future<MataKuliah> createMataKuliah(MataKuliah mataKuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(mataKuliah.toJson()),
    );
    if (response.statusCode == 201) {
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mengambil Data mata kuliah');
    }
  }

  Future<MataKuliah> updateMataKuliah(int id, MataKuliah mataKuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(mataKuliah.toJson()),
    );
    if (response.statusCode == 200) {
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal untuk update mata kuliah');
    }
  }

  Future<void> deleteMataKuliah(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Gagal untuk hapus mata kuliah');
    }
  }
}
