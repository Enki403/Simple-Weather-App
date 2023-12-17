import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Weather App")),
        body: _HomeView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // ToDo: Navegar a pantalla de busqueda
          },
          tooltip: 'Search',
          child: const Icon(Icons.search),
        ));
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(children: [
        Text("Here goes the data"),
      ]),
    );
  }
}
