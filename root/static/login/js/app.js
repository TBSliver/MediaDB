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
        templateUrl : 'static/login/pages/login.html',
        controller  : 'loginController',
        css         : 'static/login/css/login.css'
      })
      // someone typed in the wrong thing
      .otherwise({
        templateUrl : 'static/login/pages/error404.html',
        controller  : 'error404Controller'
      });
  });
