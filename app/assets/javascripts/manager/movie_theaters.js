function myGetrooms(rooms){
  $("#movie_theater_theater_id").on("change", function(){
    theater_id = $("#movie_theater_theater_id option:selected").val();
    $.ajax({
      type: "GET",
      dataType: "script",
      url: '/manager/movie_theaters/get_rooms',
      data: {
        "theater_id": theater_id,
        "rooms": rooms
      }
    });
  });
}
function initDataTableMovieTheater(){
  $("#movie_theater").DataTable({
   destroy: true,
   order: []
  });
}

$(document).ready(function() {
  $("#movie_theater").DataTable();
  initDataTableMovieTheater();
});
