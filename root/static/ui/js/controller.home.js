angular
  .module('MediaDB')
  .controller('homeController', ['$scope', HomeController]);

function HomeController($scope) {
  $scope.message = 'Everyone come and see how good I look!';
};
