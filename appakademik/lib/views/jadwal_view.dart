import 'package:flutter/material.dart';
import 'package:appakademik/models/jadwal.dart';
import 'package:appakademik/controllers/jadwal_controller.dart';

class JadwalPage extends StatefulWidget {
  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  final JadwalService _service = JadwalService();
  List<Jadwal> _jadwalList = [];
  late Jadwal _selectedJadwal;
  @override
  void initState() {
    super.initState();
    _fetchJadwal();
  }

  Future<void> _fetchJadwal() async {
    List<Jadwal> jadwalList = await _service.getJadwal();
    setState(() {
      _jadwalList = jadwalList;
    });
  }

  void _showForm(BuildContext context, {Jadwal? jadwal}) {
    final isEdit = jadwal != null;
    // Pindahkan deklarasi `jadwal` agar tidak digunakan sebelum dideklarasikan.
    final String? namaMatakuliah = isEdit ? jadwal!.namaMatakuliah : '';
    final String? tanggal = isEdit ? jadwal.tanggal : '';
    final String? jam = isEdit ? jadwal.jam : '';
    final String? ruangan = isEdit ? jadwal.ruangan : '';
    // Jika Anda menggunakan TextEditingController
    final namaMatakuliahController = TextEditingController(
      text: namaMatakuliah,
    );
    final tanggalController = TextEditingController(text: tanggal);
    final jamController = TextEditingController(text: jam);
    final ruanganController = TextEditingController(text: ruangan);
    // Rest of your modal implementation...
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaMatakuliahController,
                decoration: InputDecoration(labelText: 'Nama Mata Kuliah'),
              ),
              TextField(
                controller: tanggalController,
                decoration: InputDecoration(labelText: 'Tanggal (YYYY-MM-DD)'),
              ),
              TextField(
                controller: jamController,
                decoration: InputDecoration(labelText: 'Jam'),
              ),
              TextField(
                controller: ruanganController,
                decoration: InputDecoration(labelText: 'Ruangan'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEdit ? 'Update' : 'Simpan'),
                onPressed: () {
                  final newJadwal = Jadwal(
                    id: isEdit ? jadwal.id : null,
                    namaMatakuliah: namaMatakuliahController.text,
                    tanggal: tanggalController.text,
                    jam: jamController.text,
                    ruangan: ruanganController.text,
                  );
                  if (isEdit) {
                    _service.updateJadwal(jadwal.id!, newJadwal).then((_) {
                      _fetchJadwal();
                      Navigator.pop(context);
                    });
                  } else {
                    _service.createJadwal(newJadwal).then((_) {
                      _fetchJadwal();
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteJadwal(int id) {
    _service.deleteJadwal(id).then((_) {
      _fetchJadwal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jadwal')),
      body: ListView.builder(
        itemCount: _jadwalList.length,
        itemBuilder: (context, index) {
          final jadwal = _jadwalList[index];
          return ListTile(
            title: Text(jadwal.namaMatakuliah),
            subtitle: Text(
              '${jadwal.tanggal} - ${jadwal.jam} (${jadwal.ruangan})',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showForm(context, jadwal: jadwal),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteJadwal(jadwal.id!),
                ),
              ],
            ),
            onTap: () => _showForm(context, jadwal: jadwal),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(context),
      ),
    );
  }
}
