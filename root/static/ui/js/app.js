'use strict';

angular
  .module('MediaDB', [
    'ui.bootstrap',
    'ngRoute',
    'routeStyles'
  ])
  .config(function($routeProvider) {

    $routeProvider
      .when('/', {
        templateUrl : 'static/ui/pages/home.html',
        controller  : 'homeController',
        css         : 'static/ui/css/home.css'
      })
      .when('/settings', {
        templateUrl : 'static/ui/pages/settings.html',
        controller  : 'settingsController',
        css         : 'static/ui/css/settings.css'
      })
      // someone typed in the wrong thing
      .otherwise({
        templateUrl : 'static/ui/pages/error404.html',
        controller  : 'error404Controller'
      });
  });
