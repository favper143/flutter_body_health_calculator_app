import 'package:flutter/material.dart';

enum Gender { male, female }

class BmrUi extends StatefulWidget {
  const BmrUi({super.key});

  @override
  State<BmrUi> createState() => _BmrUiState();
}

class _BmrUiState extends State<BmrUi> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  Gender _gender = Gender.male;
  double? _bmrResult;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateBmr() {
    final weight = double.tryParse(_weightController.text.replaceAll(',', '.'));
    final height = double.tryParse(_heightController.text.replaceAll(',', '.'));
    final age = double.tryParse(_ageController.text.replaceAll(',', '.'));

    if (weight == null || height == null || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกน้ำหนัก ส่วนสูง และอายุให้ถูกต้อง')),
      );
      return;
    }

    double bmr;
    if (_gender == Gender.male) {
      bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
    } else {
      bmr = 665 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    }

    setState(() {
      _bmrResult = bmr;
    });
  }

  void _clear() {
    _weightController.clear();
    _heightController.clear();
    _ageController.clear();
    setState(() {
      _bmrResult = null;
      _gender = Gender.male;
    });
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    String? suffix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR คำนวณพื้นฐาน'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/exercise.png',
                height: 150,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<Gender>(
                    title: const Text('ชาย'),
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (v) {
                      if (v != null) setState(() => _gender = v);
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<Gender>(
                    title: const Text('หญิง'),
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (v) {
                      if (v != null) setState(() => _gender = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildNumberField(
              controller: _weightController,
              label: 'น้ำหนัก (กก.)',
              suffix: 'kg',
            ),
            const SizedBox(height: 12),
            _buildNumberField(
              controller: _heightController,
              label: 'ส่วนสูง (ซม.)',
              suffix: 'cm',
            ),
            const SizedBox(height: 12),
            _buildNumberField(
              controller: _ageController,
              label: 'อายุ (ปี)',
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateBmr,
                    child: const Text('คำนวณ BMR'),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _clear,
                  child: const Text('ล้าง'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_bmrResult != null)
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'ผล BMR',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _bmrResult!.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _gender == Gender.male ? 'สูตรสำหรับผู้ชาย' : 'สูตรสำหรับผู้หญิง',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
