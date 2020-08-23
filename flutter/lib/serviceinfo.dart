class ServiceInfo {
  const ServiceInfo({this.name, this.running});

  final String name;

  final bool running;

  String status() {
    if (running) {
      return "running";
    }
    return "stopped";
  }

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(name: json['name'], running: json['running']);
  }
}
