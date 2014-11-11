angular
  .module('MediaDB')
  .controller('aboutController', ['$scope', AboutController]);

function AboutController($scope) {
  $scope.message = 'This is a MediaDB for storing all your DVD, CD, etc. records in.';
};
