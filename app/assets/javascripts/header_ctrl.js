(function() { 'use strict'; angular.module('app', [])
.controller('headerCtrl', ['$scope', function($scope) {
$scope.toggleIcon = function() { 
  $scope.ext = if (ext != 'seizure') { $scope.ext = 'seizure'; } 
               else { $scope.ext = 'circle'; }
}

window.$scope = $scope;
});
}])();