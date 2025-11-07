enum AppRoutes {
  home(name: 'home', path: '/'),
  details(name: 'details', path: '/details'),
  favorites(name: 'favorites', path: '/favorites'),
  localDetails(name: 'localdetails', path: '/localdetails');

  const AppRoutes({required this.name, required this.path});

  final String name;
  final String path;
}
