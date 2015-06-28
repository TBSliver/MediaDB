angular
  .module('MediaDB')
  .controller('EditLocationModalController', [
    '$scope',
    '$http',
    '$modalInstance',
    'location_id',
    function ($scope, $http, $modalInstance, location_id) {

      $scope.heading = "Edit Location";
      $scope.show_delete = true;
      $scope.location = { 'name' : null };

      $http
        .post( '/api/location/get',
          { 'id' : location_id }
        )
        .success( function( data ) {
          if( data.success ) {
            $scope.location = data.data.location;
          } else {
            console.log( "Something Went Wrong" );
          }
        })
        .error( function( data ) {
          console.log( "Dagnabit" );
        });

      $scope.cancel = function () {
        $modalInstance.dismiss( 'cancel' );
      };

      $scope.save = function() {
        console.log( $scope.location );
        $http
          .post( '/api/location/edit',
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

      $scope.delete = function() {
        $http
          .post( '/api/location/delete',
            { 'id' : location_id }
          )
          .success( function( data ) {
            if( data.success ) {
              $modalInstance.close();
            } else {
              console.log( "Something Went Wrong" );
            }
          })
          .error( function( data ) {
            console.log( "Dagnabit" );
          });
      };
    }
  ]);
