function searchProduct(value){
  $.ajax({
    type: 'get',
    url: '/search',
    data: {
        search_keyword: value
    },
    dataType: 'script'
  })
}
document.addEventListener('turbolinks:load', function () {
  $('#search').on('keyup', function(){
    let search = $(this).val();
    if(search.length > 1){
      searchProduct(search);
    }
    else {
      $('#show-search-product').addClass('d_none')
    }
  })
})
