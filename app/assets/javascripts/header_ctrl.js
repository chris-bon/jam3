(function() { 
  'use strict'; 
  angular.module('app').controller('headerCtrl', ['$scope', function($scope) {
    $scope.toggleIcon = function() { 
      if ($scope.ext != 'seizure') { 
        $scope.ext = 'seizure'; 
      } else { 
        $scope.ext = 'circle'; 
      }
    window.$scope = $scope;
    };
  }]);
})();