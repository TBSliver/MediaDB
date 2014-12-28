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
        controller  : 'homeController'
      })
      // someone typed in the wrong thing
      .otherwise({
        templateUrl : 'static/ui/pages/error404.html',
        controller  : 'error404Controller'
      });
  });
