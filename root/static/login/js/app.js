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
      .when('/forgot', {
        templateUrl : 'static/login/pages/forgot.html',
        controller  : 'forgotController',
        css         : 'static/login/css/forgot.css'
      })
      .when('/set/:key', {
        templateUrl : 'static/login/pages/set.html',
        controller  : 'setController',
        css         : 'static/login/css/set.css'
      })
      // someone typed in the wrong thing
      .otherwise({
        templateUrl : 'static/login/pages/error404.html',
        controller  : 'error404Controller'
      });
  });
