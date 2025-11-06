enum AppRoutes {
  home(name: 'home', path: '/'),
  details(name: 'details', path: '/details'),
  favorites(name: 'favorites', path: '/favorites');

  const AppRoutes({required this.name, required this.path});

  final String name;
  final String path;
}
