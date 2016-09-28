Ctrl = ($scope,$state,Session,growl,$http,Auth,Product)->

  $scope.products = []
  $scope.categories = []
  $scope.errors = []
  tempProduct = {}
  tempCategory = {}

  $scope.uiState =
    productForm: false

  $scope.hide =
    formProduct: true
    buttonProduct: false
    form: true
    button: false

  $scope.product =
    name: ""
    price: 0
    state: "show"

  $scope.category =
    name: ""
    state: "show"

  $scope.sortVal = ""

  $scope.cancelEdit =(obj)->
    obj.name = tempProduct.name
    obj.price = tempProduct.price
    obj.state = 'show'
    tempProduct = {}

  $scope.saveProduct =(obj)->
    $http.patch("/api/products/#{obj.id}", {product: obj})
    obj.state = 'show'
    for category in $scope.categories
      if category.id == obj.category_id
        obj.category = category.name
    #obj.save()

  $scope.deleteProduct =(obj)->
    Product.delete({id: obj.id})
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
      .then (data)->
        for product in data
          product.state = 'show'
          for category in $scope.categories
            if category.id == product.category_id
              product.category = category.name
          $scope.products.push product

  $scope.addProduct =(product)->
    Product.save({product: product}).$promise
      .then (data)->
        data.state = 'show'
        for category in $scope.categories
            if category.id == data.category_id
              data.category = category.name
        $scope.products.unshift(data)
    # $http.post("/api/products", {product: $scope.product})
    #   .then (response) ->
    #     response.data.state = 'show'
    #     $scope.products.unshift(response.data)
    #     $scope.product =
    #       name: ""
    #       price: 0
      .catch (err)->
        $scope.errors = []
        for e in err.data
          $scope.errors.push(e)

  $scope.calculateAge = ->
    return parseFloat($scope.user.age)+1

  $scope.addCategory = ->
    $http.post("/api/categories", {category: $scope.category})
      .then (response) ->
        response.data.state = 'show'
        $scope.categories.push(response.data)
        $scope.category =
          name: ""
      .catch (err)->
        debugger

  $scope.deleteCategory =(obj)->
    $http.delete("/api/categories/#{obj.id}")
    debugger
    for p in $scope.products
      if p.category_id == obj.id
        p.category_id = $scope.categories[0].id
        $scope.saveProduct(p)
    $scope.categories.splice($scope.categories.indexOf(obj),1)

  $scope.editCategory =(category)->
    tempCategory = angular.copy category
    category.state = 'edit'

  $scope.cancelEditC =(obj)->
      obj.name = tempCategory.name
      obj.state = 'show'
      tempCategory = {}

  $scope.saveCategory =(obj)->
    $http.patch("/api/categories/#{obj.id}", {category: obj})
    obj.state = 'show'

  $scope.getCategories = ->
    $http.get("/api/categories")
      .then (response)->
        for category in response.data
          category.state = 'show'
          $scope.categories.push category
        $scope.product.category_id = $scope.categories[0].id

  $scope.showForm = ->
    if $scope.hide.buttonProduct == false
      $scope.hide.formProduct = false
      $scope.hide.buttonProduct = true
    else
      $scope.hide.formProduct = true
      $scope.hide.buttonProduct = false

  $scope.sortBy =(val)->
    $scope.sortVal = val


  $scope.getCategories()
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
