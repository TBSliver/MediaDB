angular
  .module('MediaDB')
  .controller('homeController', [
    '$scope',
    '$http',
    '$modal',
    function ($scope, $http, $modal) {

      var get_movies = function() {
        $http
          .get( '/api/movie' )
          .success( function( data ) {
            if( data.success ) {
              $scope.movies = data.data.movies;
            } else {
              console.log( "Something Went Wrong" );
            }
          })
          .error( function( data ) {
            console.log( "Dagnabit" );
          });
      };

      var get_locations = function() {
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
      };

      get_movies();
      get_locations();

      $scope.add_movie = function() {
        var modal = $modal.open({
          templateUrl : 'static/ui/pages/modal/movie.html',
          controller  : 'AddMovieModalController'
        });

        modal.result.then( function() {
          // Save Pressed
          get_movies();
        }, function() {
          // Cancel Pressed
        });
      };

      $scope.edit_movie = function( movie_id ) {
        var modal = $modal.open({
          templateUrl : 'static/ui/pages/modal/movie.html',
          controller  : 'EditMovieModalController',
          resolve     : {
            'movie_id' : function() { return movie_id; }
          }
        });

        modal.result.then( function() {
          // Save Pressed
          get_movies();
        }, function() {
          // Cancel Pressed
        });
      };

      $scope.add_location = function() {
        var modal = $modal.open({
          templateUrl : 'static/ui/pages/modal/location.html',
          controller  : 'AddLocationModalController'
        });

        modal.result.then( function() {
          // Save Pressed
          get_locations();
        }, function() {
          // Cancel Pressed
        });
      };

      $scope.edit_location = function( location_id ) {
        var modal = $modal.open({
          templateUrl : 'static/ui/pages/modal/location.html',
          controller  : 'EditLocationModalController',
          resolve     : {
            'location_id' : function() { return location_id; }
          }
        });

        modal.result.then( function() {
          // Save Pressed
          // Need to update movies as the location name may have changed
          get_movies();
          get_locations();
        }, function() {
          // Cancel Pressed
        });
      };
    }
  ]);
