// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordBox'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildFeatureCard(
            context,
            Icons.list,
            'Kelime Listeleri',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WordListsScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.add_circle,
            'Liste Oluştur',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateListScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.edit,
            'Kelime Ekleme',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddWordsScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.school,
            'Öğrenme Modu',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LearningModeScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.quiz,
            'Test Modu',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TestModeScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.analytics,
            'İlerleme Takibi',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.search,
            'Arama',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.person,
            'Profil',
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuickAddScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Word Lists Screen
class WordListsScreen extends StatelessWidget {
  const WordListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleLists = [
      {'name': 'İngilizce Temel Kelimeler', 'count': 50, 'language': 'İngilizce', 'progress': 0.75},
      {'name': 'İş İngilizcesi', 'count': 32, 'language': 'İngilizce', 'progress': 0.4},
      {'name': 'Almanca A1 Seviye', 'count': 45, 'language': 'Almanca', 'progress': 0.2},
      {'name': 'Fransızca Günlük', 'count': 28, 'language': 'Fransızca', 'progress': 0.9},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelime Listelerim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: sampleLists.length,
        itemBuilder: (context, index) {
          final list = sampleLists[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                child: Text(list['language'].toString()[0]),
              ),
              title: Text(list['name'].toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${list['count']} kelime • ${list['language']}'),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: list['progress'] as double,
                    backgroundColor: Colors.grey[200],
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDetailScreen(list: list),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrele'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('İngilizce'),
              value: true,
              onChanged: (v) {},
            ),
            CheckboxListTile(
              title: const Text('Almanca'),
              value: false,
              onChanged: (v) {},
            ),
            CheckboxListTile(
              title: const Text('Fransızca'),
              value: false,
              onChanged: (v) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Uygula'),
          ),
        ],
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sırala'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('Ada göre (A-Z)'),
              value: 0,
              groupValue: 0,
              onChanged: (v) {},
            ),
            RadioListTile(
              title: const Text('Kelime sayısına göre'),
              value: 1,
              groupValue: 0,
              onChanged: (v) {},
            ),
            RadioListTile(
              title: const Text('İlerlemeye göre'),
              value: 2,
              groupValue: 0,
              onChanged: (v) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Uygula'),
          ),
        ],
      ),
    );
  }
}

// List Detail Screen
class ListDetailScreen extends StatelessWidget {
  final Map<String, dynamic> list;

  const ListDetailScreen({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleWords = [
      {'word': 'Apple', 'meaning': 'Elma', 'example': 'I eat an apple every day.'},
      {'word': 'Book', 'meaning': 'Kitap', 'example': 'This book is very interesting.'},
      {'word': 'Computer', 'meaning': 'Bilgisayar', 'example': 'I work on my computer all day.'},
      {'word': 'Dog', 'meaning': 'Köpek', 'example': 'My dog is very friendly.'},
      {'word': 'Elephant', 'meaning': 'Fil', 'example': 'Elephants are large animals.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(list['name'].toString()),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list['name'].toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '${list['count']} kelime • ${list['language']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: list['progress'] as double,
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${((list['progress'] ?? 0.0) * 100).toInt()}% tamamlandı',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('İlerlemeyi Sıfırla'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: sampleWords.length,
              itemBuilder: (context, index) {
                final word = sampleWords[index];
                return ListTile(
                  title: Text(word['word'].toString()),
                  subtitle: Text(word['meaning'].toString()),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(word['word'].toString()),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Anlam: ${word['meaning']}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            const Text('Örnek Cümle:'),
                            Text(word['example'].toString()),
                            const SizedBox(height: 16),
                            const Text('Hatırlama Oranı: 80%'),
                            LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.grey[200],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Kapat'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddWordsScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Create List Screen
class CreateListScreen extends StatefulWidget {
  const CreateListScreen({Key? key}) : super(key: key);

  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contextController = TextEditingController();
  String _selectedLanguage = 'İngilizce';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Liste Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Liste Adı',
                  hintText: 'Örneğin: İş İngilizcesi Kelimeler',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir liste adı girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama (İsteğe Bağlı)',
                  hintText: 'Liste hakkında kısa bir açıklama',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                items: ['İngilizce', 'Almanca', 'Fransızca', 'İspanyolca', 'Japonca']
                    .map((lang) => DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Dil',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contextController,
                decoration: const InputDecoration(
                  labelText: 'Bağlam (İsteğe Bağlı)',
                  hintText: 'Örneğin: İş toplantılarında kullanılan kelimeler',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddWordsScreen(
                          listName: _nameController.text,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Listeyi Oluştur ve Kelime Ekle'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Liste başarıyla oluşturuldu!'),
                      ),
                    );
                  }
                },
                child: const Text('Sadece Listeyi Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add Words Screen
class AddWordsScreen extends StatefulWidget {
  final String? listName;

  const AddWordsScreen({Key? key, this.listName}) : super(key: key);

  @override
  _AddWordsScreenState createState() => _AddWordsScreenState();
}

class _AddWordsScreenState extends State<AddWordsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  final _exampleController = TextEditingController();
  final List<Map<String, String>> _words = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listName != null
            ? '${widget.listName} - Kelime Ekle'
            : 'Kelime Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _wordController,
                    decoration: const InputDecoration(
                      labelText: 'Kelime',
                      hintText: 'Örneğin: Computer',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir kelime girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _meaningController,
                    decoration: const InputDecoration(
                      labelText: 'Anlamı',
                      hintText: 'Örneğin: Bilgisayar',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen kelimenin anlamını girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _exampleController,
                    decoration: const InputDecoration(
                      labelText: 'Örnek Cümle (İsteğe Bağlı)',
                      hintText: 'Örneğin: I use my computer every day.',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _words.add({
                                  'word': _wordController.text,
                                  'meaning': _meaningController.text,
                                  'example': _exampleController.text,
                                });
                                _wordController.clear();
                                _meaningController.clear();
                                _exampleController.clear();
                              });
                            }
                          },
                          child: const Text('Ekle'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Toplu Kelime Ekle'),
                                content: const Text('Bu özellik premium sürümde mevcuttur.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('Toplu Ekle'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _words.isEmpty
                  ? const Center(
                child: Text('Henüz kelime eklenmedi'),
              )
                  : ListView.builder(
                itemCount: _words.length,
                itemBuilder: (context, index) {
                  final word = _words[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(word['word']!),
                      subtitle: Text(word['meaning']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _words.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_words.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${_words.length} kelime başarıyla eklendi!'),
                      ),
                    );
                  },
                  child: const Text('Kaydet ve Bitir'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Learning Mode Screen
class LearningModeScreen extends StatelessWidget {
  const LearningModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenme Modu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Öğrenme Modu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Bu bölümde çeşitli alıştırmalarla kelimeleri öğrenebilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LearningSessionScreen(),
                  ),
                );
              },
              child: const Text('Başla'),
            ),
          ],
        ),
      ),
    );
  }
}

// Learning Session Screen
class LearningSessionScreen extends StatefulWidget {
  const LearningSessionScreen({Key? key}) : super(key: key);

  @override
  _LearningSessionScreenState createState() => _LearningSessionScreenState();
}

class _LearningSessionScreenState extends State<LearningSessionScreen> {
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  int _streak = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'word': 'Apple',
      'meaning': 'Elma',
      'options': ['Elma', 'Armut', 'Muz', 'Portakal'],
      'image': 'assets/images/apple.png',
    },
    {
      'word': 'Book',
      'meaning': 'Kitap',
      'options': ['Kalem', 'Defter', 'Kitap', 'Silgi'],
      'image': 'assets/images/book.png',
    },
    {
      'word': 'Computer',
      'meaning': 'Bilgisayar',
      'options': ['Telefon', 'Bilgisayar', 'Tablet', 'Televizyon'],
      'image': 'assets/images/computer.png',
    },
  ];

  void _answerQuestion(String selectedAnswer) {
    final isCorrect = selectedAnswer == _questions[_currentQuestion]['meaning'];

    setState(() {
      if (isCorrect) {
        _correctAnswers++;
        _streak++;
      } else {
        _streak = 0;
      }

      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        // End of questions
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Tebrikler!'),
            content: Text('Testi tamamladınız!\nDoğru cevaplar: $_correctAnswers/${_questions.length}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tamam'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Soru ${_currentQuestion + 1}/${_questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text('Seri: $_streak'),
              backgroundColor: Colors.amber[100],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Bu kelimenin anlamı nedir?',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    // Resim eklenen kısım
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(currentQ['image']),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentQ['word'],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ...(currentQ['options'] as List<String>).map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => _answerQuestion(option),
                  child: Text(option),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// Test Mode Screen
class TestModeScreen extends StatelessWidget {
  const TestModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Modu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Test Modu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Bu bölümde kelime bilginizi test edebilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TestSessionScreen(),
                  ),
                );
              },
              child: const Text('Teste Başla'),
            ),
          ],
        ),
      ),
    );
  }
}

// Test Session Screen
class TestSessionScreen extends StatefulWidget {
  const TestSessionScreen({Key? key}) : super(key: key);

  @override
  _TestSessionScreenState createState() => _TestSessionScreenState();
}

class _TestSessionScreenState extends State<TestSessionScreen> {
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  int _timeLeft = 60;
  bool _showResults = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'word': 'Apple',
      'meaning': 'Elma',
      'options': ['Elma', 'Armut', 'Muz', 'Portakal'],
    },
    {
      'word': 'Book',
      'meaning': 'Kitap',
      'options': ['Kalem', 'Defter', 'Kitap', 'Silgi'],
    },
    {
      'word': 'Computer',
      'meaning': 'Bilgisayar',
      'options': ['Telefon', 'Bilgisayar', 'Tablet', 'Televizyon'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_timeLeft > 0 && !_showResults) {
        setState(() => _timeLeft--);
        _startTimer();
      } else if (!_showResults) {
        setState(() => _showResults = true);
      }
    });
  }

  void _answerQuestion(String selectedAnswer) {
    final isCorrect = selectedAnswer == _questions[_currentQuestion]['meaning'];

    setState(() {
      if (isCorrect) {
        _correctAnswers++;
      }

      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _showResults = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showResults) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Test Sonuçları'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Test Tamamlandı!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Doğru Cevaplar: $_correctAnswers/${_questions.length}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Başarı Oranı: ${(_correctAnswers / _questions.length * 100).toInt()}%',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TestSessionScreen(),
                    ),
                  );
                },
                child: const Text('Yeni Test Başlat'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ana Menüye Dön'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQ = _questions[_currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Soru ${_currentQuestion + 1}/${_questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text('$_timeLeft sn'),
              backgroundColor: Colors.red[100],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Bu kelimenin anlamı nedir?',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentQ['word'],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ...(currentQ['options'] as List<String>).map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => _answerQuestion(option),
                  child: Text(option),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// Progress Screen
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlerleme Takibi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Genel İstatistikler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildStatRow('Toplam Öğrenilen Kelime', '142'),
                    const Divider(),
                    _buildStatRow('Aktif Seri', '5 gün'),
                    const Divider(),
                    _buildStatRow('En Uzun Seri', '12 gün'),
                    const Divider(),
                    _buildStatRow('Toplam Test Tamamlama', '23'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Son Çalışmalar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRecentActivity('İngilizce Temel Kelimeler', '80%', '2 gün önce'),
                    const Divider(),
                    _buildRecentActivity('İş İngilizcesi', '65%', '3 gün önce'),
                    const Divider(),
                    _buildRecentActivity('Almanca A1', '45%', '1 hafta önce'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Önerilen Kelimeler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSuggestedWord('Persistent', 'Israrlı'),
                _buildSuggestedWord('Diligent', 'Çalışkan'),
                _buildSuggestedWord('Ambiguous', 'Belirsiz'),
                _buildSuggestedWord('Comprehensive', 'Kapsamlı'),
                _buildSuggestedWord('Elaborate', 'Ayrıntılı'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(String list, String progress, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(list),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Chip(
            label: Text(progress),
            backgroundColor: Colors.blue[50],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedWord(String word, String meaning) {
    return Chip(
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(word),
          Text(
            meaning,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
    );
  }
}

// Search Screen
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arama'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              hintText: 'Liste, kelime veya anlam ara...',
              onTap: () {},
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Son Aramalar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ActionChip(
                      label: const Text('İş İngilizcesi'),
                      onPressed: () {},
                    ),
                    ActionChip(
                      label: const Text('Computer'),
                      onPressed: () {},
                    ),
                    ActionChip(
                      label: const Text('Almanca'),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Popüler Listeler',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...List.generate(3, (index) => _buildSearchResultItem()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem() {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.list)),
        title: const Text('İngilizce Temel Kelimeler'),
        subtitle: const Text('50 kelime • 75% tamamlandı'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _dailyReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Görünüm',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Koyu Tema'),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
            },
          ),
          const Divider(),
          const Text(
            'Bildirimler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Bildirimler'),
            value: _notifications,
            onChanged: (value) {
              setState(() => _notifications = value);
            },
          ),
          SwitchListTile(
            title: const Text('Günlük Hatırlatıcı'),
            value: _dailyReminder,
            onChanged: (value) {
              setState(() => _dailyReminder = value);
            },
          ),
          const Divider(),
          const Text(
            'Hesap',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Uygulama Dili'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Yardım ve Destek'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Hakkında'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'WordBox v1.0.0',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kullanıcı Adı',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('kullanici@email.com'),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileStat('Toplam Liste', '8'),
                    const Divider(),
                    _buildProfileStat('Toplam Kelime', '142'),
                    const Divider(),
                    _buildProfileStat('Üyelik Tarihi', '12.05.2023'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Profili Düzenle'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Quick Add Screen
class QuickAddScreen extends StatelessWidget {
  const QuickAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hızlı Kelime Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Kelime',
                hintText: 'Eklemek istediğiniz kelime',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Anlamı',
                hintText: 'Kelimenin anlamı',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Liste Seçin',
              ),
              items: [
                'İngilizce Temel Kelimeler',
                'İş İngilizcesi',
                'Almanca A1'
              ].map((list) => DropdownMenuItem(
                value: list,
                child: Text(list),
              )).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kelime başarıyla eklendi!'),
                  ),
                );
              },
              child: const Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}

// Search Bar Widget
class SearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;

  const SearchBar({
    Key? key,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onTap: onTap,
    );
  }
}