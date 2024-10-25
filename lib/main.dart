import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Produk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductForm(),
    );
  }
}

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _kodeProdukController = TextEditingController();
  TextEditingController _namaBarangController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _stokController = TextEditingController();
  TextEditingController _jumlahBeliController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String nama = _namaController.text;
      String kodeProduk = _kodeProdukController.text;
      String namaBarang = _namaBarangController.text;
      double harga = double.tryParse(_hargaController.text) ?? 0;
      int jumlahBeli = int.tryParse(_jumlahBeliController.text) ?? 0;

      double total = harga * jumlahBeli;
      double diskon = total > 10000000 ? total * 10 / 100 : 0;
      double grandTotal = total - diskon;

      // Pindah ke layar output
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(
            nama: nama,
            kodeProduk: kodeProduk,
            namaBarang: namaBarang,
            total: total,
            diskon: diskon,
            grandTotal: grandTotal,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Produk"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kodeProdukController,
                decoration: InputDecoration(labelText: 'Kode Produk'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kode produk';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaBarangController,
                decoration: InputDecoration(labelText: 'Nama Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama barang';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan harga';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stokController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan stok';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jumlahBeliController,
                decoration: InputDecoration(labelText: 'Jumlah Beli'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jumlah beli';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Hitung'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OutputScreen extends StatelessWidget {
  final String nama;
  final String kodeProduk;
  final String namaBarang;
  final double total;
  final double diskon;
  final double grandTotal;

  OutputScreen({
    required this.nama,
    required this.kodeProduk,
    required this.namaBarang,
    required this.total,
    required this.diskon,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil Perhitungan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $nama'),
            Text('Kode Produk: $kodeProduk'),
            Text('Nama Barang: $namaBarang'),
            SizedBox(height: 20),
            Text('Total: Rp ${total.toStringAsFixed(2)}'),
            Text('Diskon: Rp ${diskon.toStringAsFixed(2)}'),
            Text('Grand Total: Rp ${grandTotal.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}