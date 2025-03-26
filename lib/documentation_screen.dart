import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class DocumentationScreen extends StatefulWidget {
  @override
  _DocumentationScreenState createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  String _markdownData = 'Загрузка документации...';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  Future<void> _loadMarkdown() async {
    try {
      final response = await http.get(Uri.parse(
          'https://54895834958493.github.io/calculator-docs/documentation.md'));
      if (response.statusCode == 200) {
        setState(() {
          _markdownData = response.body;
        });
      } else {
        setState(() {
          _markdownData = 'Ошибка загрузки документации. Код ошибки: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _markdownData = 'Ошибка загрузки документации: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Документация'),
      ),
      body: Container(
        color: Colors.white, // Белый фон для контейнера
        padding: EdgeInsets.all(16), // Добавляем отступы
        child: SingleChildScrollView(
          child: MarkdownBody(
            data: _markdownData,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(fontSize: 16, color: Colors.black), // Стиль для текста
              h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              h3: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              strong: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Стиль для жирного текста
              listBullet: TextStyle(color: Colors.black), // Стиль для маркеров списка
              code: TextStyle(backgroundColor: Colors.grey[200], color: Colors.black), // Стиль для кода
            ),
          ),
        ),
      ),
    );
  }
}