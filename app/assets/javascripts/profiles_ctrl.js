(function() {'use strict'; 
angular.module('app')
.controller('profilesCtrl', ['$scope', '$http', function($scope, $http) {

  // $scope.setup = function() {

  //   $http.get('/profiles.json').then(function(response) {
  //     $scope.profiles = response.data;
  //   });
  // };

  $scope.profs = @profs;

  $scope.toggleOrder = function(attribute) {

    if(attribute != $scope.orderAttribute) {
      $scope.descending = false;
    } else {
      $scope.descending = !$scope.descending;
    };
    $scope.orderAttribute = attribute; 
  };
  window.$scope = $scope;
}]);
})();