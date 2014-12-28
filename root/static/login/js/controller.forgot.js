angular
  .module('MediaDB')
  .controller('forgotController', ['$scope', '$http', '$modal', ForgotController])
  .controller('forgotModalController', ['$scope', '$modalInstance', '$location', ForgotModalController]);

function ForgotController ($scope, $http, $modal) {

  $scope.processForgot = function() {

    $http
      .post('/login/reset_password', $scope.creds)
      .success(function() {

        $modal.open({
          templateUrl : '/static/login/pages/modal/forgotSuccess.html',
          controller  : 'forgotModalController'
        });

      })
      .error(function() {
        console.log("connection failed");
      })
  };

};

function ForgotModalController($scope, $modalInstance, $location) {
    $scope.close = function() {
          window.location.href='/login';
            }
};
