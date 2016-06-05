(function() {
'use strict';
angular.module('app').controller(
  'profileCtrl', ['$scope', '$http', function($scope, $http) {

$scope.setup = function() {
  $http.get('/profiles.json').then(function(response) {
    $scope.user_profiles = response.data;
  });
}

// $scope.addProfile = function(name, email) {
//   var profile = {name: name, email: email}
//   $http.post('profiles.json', profile).then(function(response) {
//     $scope.profiles.push(response.data);
//   }, function(error) {
//     $scope.errors = error.data.errors;
//   });
// }

// $scope.deleteProfile = function(profile) {
//   $http.delete('api/v1/profiles/' + profile.id + '.json').then(function(response) {
//     var index = $scope.profiles.indexOf(profile);
//     $scope.profiles.splice(index, 1);
//   });
// }

$scope.toggleOrder = function(attribute) {
  if(attribute != $scope.orderAttribute) {
    $scope.descending = false;
  } else {
    $scope.descending = !$scope.descending;
  }
  $scope.orderAttribute = attribute;
}

window.$scope = $scope;
}]);
})();