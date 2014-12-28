angular
  .module('MediaDB')
  .controller('mainController', ['$scope', MainController]);

function MainController($scope) {
  $scope.message = 'Everyone come and see how good I look!';
};
