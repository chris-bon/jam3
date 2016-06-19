(function() {'use strict'; 

angular.module('app').controller('headerCtrl', ['$scope', function($scope) {

  $scope.image_url = 'note-circle.gif'

  $scope.toggleImage = function() { 
    
    if ($scope.image_url != 'note-seizure.gif') { 
      $scope.image_url = 'note-seizure.gif'; 
    } else { 
      $scope.image_url = 'note-circle.gif'; 
    }
  };

  window.$scope = $scope;

}]);
})();