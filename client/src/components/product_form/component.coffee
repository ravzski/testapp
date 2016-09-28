Ctrl =($scope)->

  $scope.product =
    name: ""
    price: 0
    category_id: $scope.categories[0].id

  $scope.onSubmit =(form)->
    form.$submitted = true
    $scope.addProduct({product: $scope.product}) if form.$valid


angular.module('client').directive 'productForm',->
  templateUrl: 'components/product_form/index.html'
  controller: Ctrl
  restrict: "E"
  replace: true
  scope:
    addProduct: "&"
    categories: "<"


angular.module('client').directive 'pagination',->
  templateUrl: 'components/pagination/index.html'
  controller: Ctrl
  restrict: "E"
  replace: true
  scope:
    totalCount: "<"
    currentPage: "<"
    perPage: "<"
    onChange: "&"

#
# angular.module('client').component 'productForm',
#   templateUrl: 'components/product_form/index.html'
#   controller: Ctrl
