angular
  .module('MediaDB')
  .controller('settingsController', ['$scope', '$http', '$modal', SettingsController]);

function SettingsController ($scope, $http, $modal) {

  $http
    .get('/api/user')
    .success(function(data) {
      if (data.status === 200) {
        $scope.data = data.data;
      }
    })
    .error(function(data) {
      console.log("Connection Failure");
  });

  $scope.passChangeSubmitDisabled = function () {
    if (
      $scope.passChange.$valid &&
      ($scope.pass_change.password_new === $scope.pass_change.password_confirm)
    ) {
      return false;
    }
    return true;
  }

  $scope.processPassChange = function () {
    $http
      .post('/api/user/change_pass', {
        password_old : $scope.pass_change.password_old,
        password_new : $scope.pass_change.password_new
      })
      .success(function(data) {
        if (data.data.success) {
          $modal.open({
            templateUrl : '/static/ui/pages/modal/settingsPassChangeSuccess.html'
          });
        } else {
          $modal.open({
            templateUrl : '/static/ui/pages/modal/settingsPassChangeFail.html'
          });
        } 
      })
      .error(function(data) {
        console.log("Connection Failure");
    });
  }
};
