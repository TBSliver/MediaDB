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
        redirectTo  : '/home'
      })
      // route for the home page
      .when('/home', {
        templateUrl : 'ui/pages/home.html',
        controller  : 'mainController'
      })
      // route for the about page
      .when('/about', {
        templateUrl : 'ui/pages/about.html',
        controller  : 'aboutController',
        css         : 'css/about.css'
      })
      // route for the contact page
      .when('/contact', {
        templateUrl : 'ui/pages/contact.html',
        controller  : 'contactController'
      })
      // someone typed in the wrong thing
      .otherwise({
        templateUrl : 'ui/pages/error404.html',
        controller  : 'error404Controller'
      });
  });
