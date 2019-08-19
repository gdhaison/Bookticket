function initDataTableCategory(){
  $("#category").DataTable({
   destroy: true,
   order: []
  });
}

$(document).ready(function() {
  $("#category").DataTable();
  initDataTableCategory();
});
