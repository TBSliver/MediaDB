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
        templateUrl : 'login/pages/login.html',
        controller  : 'mainController',
        css         : 'login/css/login.css'
      })
      // someone typed in the wrong thing
      .otherwise({
        templateUrl : 'ui/pages/error404.html',
        controller  : 'error404Controller'
      });
  });
