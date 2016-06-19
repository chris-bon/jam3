(function() {'use strict'; 
angular.module('app')
.controller('musiciansCtrl', ['$scope', '$http', function($scope, $http) {

  $scope.setup = function() {

    $http.get('/profiles.json').then(function(response) {
      $scope.profiles = response.data;
    });
  };
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