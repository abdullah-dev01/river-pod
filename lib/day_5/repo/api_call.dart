class MyApi {
  Future<List<String>> fetchData() async {
    // Simulate a network call with a delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate data
    return ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  }
}
