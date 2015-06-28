angular
  .module('MediaDB')
  .controller('EditMovieModalController', [
    '$scope',
    '$http',
    '$modalInstance',
    'movie_id',
    function ($scope, $http, $modalInstance, movie_id) {

      $scope.heading = "Edit Movie";
      $scope.show_delete = true;
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

      $http
        .post( '/api/movie/get',
          { 'id' : movie_id }
        )
        .success( function( data ) {
          if( data.success ) {
            $scope.movie = data.data.movie;
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
          .post( '/api/movie/edit',
            $scope.movie
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

      $scope.delete = function() {
        $http
          .post( '/api/movie/delete',
            { 'id' : movie_id }
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
