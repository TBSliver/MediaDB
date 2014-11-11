angular
  .module('MediaDB')
  .controller('contactController', ['$scope', ContactController]);

function ContactController($scope) {
  $scope.message = 'Contact us! JK. This is just a demo.';
};


