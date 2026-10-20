<!-- Código JavaScript para recoger las variables en la ventana modal enviadas en el boton con el data-xxx -->

$(document).ready(function() {
    console.log('ready');       //Cuando cargue que se muestre por la consola ready, significará que nuestro JS esta funcionando
    init();
});

function init(){
   onshowratings();
}

function onshowratings(){
    $('#modalRatings').on('show.bs.modal', function (event) {
      var a = $(event.relatedTarget) // Recogemos el boton de la modal       // Y sacamos las variables que enviamos en ese botón
      var nombre = a.data('nombreplaya')
      var idplaya = a.data('idplaya')
      var modal = $(this)
      modal.find('h4').text(nombre)  // Cambiamos el h4
      //AJAX
        $.ajax({
          type: "GET",
            url: "Controller?op=puntuacion&playa="+idplaya,
            success : function(info) {
                $("#puntuacion").html(info);
            }
        });
    })
}

