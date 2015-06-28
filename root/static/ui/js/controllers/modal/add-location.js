angular
  .module('MediaDB')
  .controller('AddLocationModalController', [
    '$scope',
    '$http',
    '$modalInstance',
    function ($scope, $http, $modalInstance) {

      $scope.heading = "Add New Location";
      $scope.show_delete = false;
      $scope.location = { 'name' : null };

      $scope.cancel = function () {
        $modalInstance.dismiss( 'cancel' );
      };

      $scope.save = function() {
        console.log( $scope.location );
        $http
          .post( '/api/location/add',
            $scope.location
          )
          .success( function( data ) {
            console.log( data );
            if( data.success ) {
              $modalInstance.close();
            } else {
              alert( data.message );
            }
          })
          .error( function( data ) {
            console.log( "Dagnabit" );
          });
      };

    }
  ]);
