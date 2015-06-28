angular
  .module('MediaDB')
  .controller('AddMovieModalController', [
    '$scope',
    '$http',
    '$modalInstance',
    function ($scope, $http, $modalInstance) {

      $scope.heading = "Add New Movie";
      $scope.show_delete = false;
      $scope.movie = { 'location' : null };

      $http
        .get( '/api/location' )
        .success( function( data ) {
          if( data.success ) {
            $scope.locations = data.data.locations;
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

      $scope.save = function () {
        $http
          .post( '/api/movie/add',
            $scope.movie
          )
          .success( function( data ) {
            if( data.success ) {
              $modalInstance.close();
            } else {
              console.log( "Something Went Wrong" )
            }
          })
          .error( function( data ) {
            console.log( "Dagnabit" );
          });
      };
    }
  ]);
