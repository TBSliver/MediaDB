angular
  .module('MediaDB')
  .controller('setController', ['$scope', '$routeParams', '$modal', '$http', SetController])
  .controller('setModalController', ['$scope', '$modalInstance', '$window', 'loginRedir', SetModalController]);

function SetController ($scope, $routeParams, $modal, $http) {

  // Disable submit if the passwords dont match
  $scope.setFormSubmitDisabled = function() {
    if (
      $scope.setForm.$valid &&
      ($scope.creds.password === $scope.creds.password_confirm)
    ) {
        return false;
    }
    return true;
  }

  $scope.message = $routeParams.key;

  $scope.processSet = function() {
    $http
      .post('/login/set_password', {
        set_password_code : $routeParams.key,
        password : $scope.creds.password
      })
      .success(function(data) {
        if (data.success) {
          $modal.open({
            templateUrl : '/static/login/pages/modal/setSuccess.html',
            controller  : 'setModalController',
            resolve : {
                loginRedir: function() {
                    return data.data.redirect;
                }
            }
          });
        } else {
          $modal.open({
            templateUrl : '/static/login/pages/modal/setFail.html',
          });
        }
        console.log(data);

      })
      .error(function(data) {
        console.log("Connection Failure");
      });
  }

};

function SetModalController($scope, $modalInstance, $window, loginRedir) {
  $scope.close = function() {
    $window.location.href = loginRedir;
  }
};

