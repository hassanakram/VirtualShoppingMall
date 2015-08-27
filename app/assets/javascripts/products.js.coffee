# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $.cookie("cart_items")
    $('#cartprice').text($.cookie("total_price"))
    $('#cartqty').text($.cookie("total_items"))
    $('#my_cart_details').show()

  $('.add_to_cart').click ->
    cart_button = $(@)
    if $.cookie("cart_items") == "" || $.cookie("cart_items") == null
      $.cookie("cart_items", $(this).data("productid"), { path: '/'})
      cart_button.attr("disabled", true)
      $('#my_cart_details').show()
      $('#cartqty').text("1")
      $('#cartprice').text($(this).data("product-price"));
    else
      val = $.cookie("cart_items")
      new_product = $(this).data("productid")
      if val.search(new_product) != -1
        alert "Already in the cart!"
      else
        $.cookie("cart_items", $.cookie("cart_items") + "," + $(this).data("productid"), { path: '/'})
        cart_button.attr("disabled", true)
        $('#cartprice').text(parseInt($('#cartprice').text()) + $(this).data("product-price"))
        $('#cartqty').text(parseInt($("#cartqty").text()) + 1)
    $.cookie("total_price", $('#cartprice').text(), { path: '/'})
    $.cookie("total_items", $('#cartqty').text(), { path: '/'})

  $('.delete_from_cart').click ->
    $('#cartqty').text(parseInt($("#cartqty").text()) - 1)
    $('#cartprice').text(parseInt($('#cartprice').text()) - $(this).data("product-price"))
    $('#total-price').text(parseInt($('#total-price').text()) - $(this).data("product-price"))
    cart_products = $.cookie("cart_items")
    cart_products = cart_products.split(",")
    index = cart_products.indexOf("#{$(this).data("productid")}")
    cart_products.splice index, 1
    $.cookie("cart_items", cart_products.join(","), { path: '/'})
    $.cookie("total_price", $('#total-price').text(), { path: '/'})
    $.cookie("total_items", $('#cartqty').text(), { path: '/'})
    $(this).parent('td').parent('tr').remove()
