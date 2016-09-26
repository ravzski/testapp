module = ($resource)->

  Product = $resource "/api/products/:id", {id: "@id"},
    {
      update:
        method: 'PUT'
    }

  Product::formatPrice = ->
    "$#{@.price}"

  Product


module.$inject = ['$resource']
angular.module('client').factory('Product', module)
