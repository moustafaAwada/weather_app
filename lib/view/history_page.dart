import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure you have intl package
import '../../models/history_model.dart';
import '../../services/history_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<HistoryModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    // Load data when page starts
    _historyFuture = HistoryService().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Search History", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        // Blue Gradient Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade300],
          ),
        ),
        child: FutureBuilder<List<HistoryModel>>(
          future: _historyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.white));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading history", style: TextStyle(color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_toggle_off, size: 70, color: Colors.white54),
                    SizedBox(height: 10),
                    Text("No history yet", style: TextStyle(color: Colors.white70, fontSize: 18)),
                  ],
                ),
              );
            }

            final historyList = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.only(top: 100, left: 16, right: 16, bottom: 20),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15), // Glass effect
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    children: [
                      // Weather Icon
                      if (item.icon.isNotEmpty)
                        Image.network("https:${item.icon}", width: 50, height: 50)
                      else
                        Icon(Icons.cloud, color: Colors.white, size: 40),
                      
                      SizedBox(width: 15),
                      
                      // Text Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.cityName,
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('MMM d, h:mm a').format(item.searchTime),
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      
                      // Temperature
                      Text(
                        "${item.temp.round()}°",
                        style: TextStyle(color: Colors.orange, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}