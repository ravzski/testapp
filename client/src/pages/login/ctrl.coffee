Ctrl = ($scope,$state,Session,growl,$http,Auth,Product)->

  $scope.products = []
  $scope.myName = "rav"
  tempProduct = {}
  $scope.user =
    age: 0

  $scope.product =
    name: ""
    price: 0
    state: "show"

  $scope.cancelEdit =(obj)->
    obj.name = tempProduct.name
    obj.price = tempProduct.price
    obj.state = 'show'
    tempProduct = {}

  $scope.saveProduct =(obj)->
    $http.patch("/api/products/#{obj.id}", {product: obj})
    obj.state = 'show'
    obj.save()

  $scope.deleteProduct =(obj)->
    $http.delete("/api/products/#{obj.id}")
    $scope.products.splice($scope.products.indexOf(obj),1)

  $scope.editProduct =(product)->
    tempProduct = angular.copy product
    product.state = 'edit'

  $scope.calculateTotal = ->
    total = 0
    for obj in $scope.products
      total += parseFloat(obj.price)
    total

  $scope.getProducts = ->
    Product.query().$promise
      .then (dat)->
        for product in data
          product.state = 'show'
          $scope.products.push product

  $scope.addProduct = ->
    Product.save({product: $scope.product}).$promise
      .then (data)->
        data.state = 'show'
        $scope.products.unshift(data)
        $scope.product =
          name: ""
          price: 0

    $http.post("/api/products", {product: $scope.product})
      .then (response) ->
        response.data.state = 'show'
        $scope.products.unshift(response.data)
        $scope.product =
          name: ""
          price: 0
      .catch (err)->
        debugger

  $scope.calculateAge = ->
    return parseFloat($scope.user.age)+1

  $scope.getProducts()

  # $scope.uiState =
  #   loading: false
  #
  # $scope.login =(creds)->
  #   $scope.uiState.loading = true
  #   Session.login(credentials: creds).$promise
  #     .then (data) ->
  #       Auth.setUser(data)
  #       Session.setSession(data)
  #       Session.setHeaders(data)
  #       growl.success(MESSAGES.LOGIN_SUCCESS)
  #       $state.go("admin.users.index")
  #     .finally ->
  #       $scope.ctrl.loading = false


Ctrl.$inject = ['$scope','$state','Session','growl','$http','Auth','Product']

angular.module('client').controller('LoginCtrl', Ctrl)
