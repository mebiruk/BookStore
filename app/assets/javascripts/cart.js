function update_cart(id, num){
  $.ajax({
    type: "patch",
    url: "/carts/update",
    data: {
      product_id: id,
      quantity: num
    },
    dataType: "script"
  })
}

$(document).on('change', '.number_custom1', function(){
  let price = $(this).parents().siblings('.price').html();
  let num = $(this).val();
  let id = $(this).parents().siblings('.id').html()
  let total = price * num;
  update_cart(id, num);
  $(this).parents().siblings('.total').html(total);
})
