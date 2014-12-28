angular
  .module('MediaDB')
  .controller('loginController', ['$scope', '$http', '$modal', LoginController]);

function LoginController ($scope, $http, $modal) {

  $scope.processLogin = function() {
    $http
      .post('/login/do', $scope.creds)
      .success(function(data) {
        if (data.data.success) {
          location.href = data.data.redirect;
        } else {
          $modal.open({
            templateUrl : 'static/login/pages/modal/loginError.html'
          });
        }
      })
      .error(function(data) {
        console.log("connection failed");
      })
  }

};

