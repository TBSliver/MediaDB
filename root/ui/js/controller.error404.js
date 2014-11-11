angular
  .module('MediaDB')
  .controller('error404Controller', ['$scope', '$location', Error404Controller]);

function Error404Controller($scope, $location) {
  $scope.message = 'Im sorry, the page "' + $location.path() + '" cannot be found.';
};
