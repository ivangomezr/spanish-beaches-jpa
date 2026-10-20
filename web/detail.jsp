<%@page import="entities.Usuario"%>
<%@page import="entities.Ccaa"%>
<%@page import="java.awt.Image"%>
<%@page import="java.util.List"%>
<%@page import="entities.Images"%>
<%@page import="entities.Playa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <title>Playas</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="mycss.css">
  </head>
  <body>

      <%Playa playa = (Playa)session.getAttribute("playa");
        String comunidad = (String)session.getAttribute("comunidad");
        Long mediaPuntos = (Long)session.getAttribute("mediaPuntos");
        Usuario user = (Usuario)session.getAttribute("user");%>

    <div class="container p-0 shadow">
        <div class="bg-primary text-center text-white pb-2">
            <h1 class="nombre pt-3"><%=playa.getNombre()%></h1>
            <div class="row justify-content-center align-items-center mx-0">
                <img src="img/ccaa_<%=comunidad%>.png" alt="" width="75px" height="50px" class="rounded shadow-sm">
                <p class="ccaa mx-3 mb-0 lead"> <%=playa.getMunicipio().getNombre()%> (<%=playa.getMunicipio().getProvincia().getNombre()%>) </p>
                <img src="img/ccaa_<%=comunidad%>.png" alt="" width="75px" height="50px" class="rounded shadow-sm">
            </div>
            <p class="mx-5 mt-3"><%=playa.getDescripcion()%></p>
        </div>

        <div class="row mx-0">
            <div class="col-md-6 p-0">
                <!-- Carousel -->
                <%if(playa.getImagesList().isEmpty()) {%>
                    <div class="sin-foto h-100" style="min-height:300px">
                        <span>Sin foto disponible</span>
                    </div>
                <%} else {%>
                <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                  <div class="carousel-inner">
                      <%for(int i = 0; i < playa.getImagesList().size(); i++) {
                      if(i == 0) { %>
                      <div class="carousel-item active">
                          <img class="d-block w-100" src="img/<%=playa.getId()%>_<%=playa.getImagesList().get(i).getId()%>.jpg" onerror="this.src='img/logo.png'" alt="">
                      </div>
                      <%}else{%>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="img/<%=playa.getId()%>_<%=playa.getImagesList().get(i).getId()%>.jpg" onerror="this.src='img/logo.png'" alt="">
                        </div>
                        <% } %>
                    <% } %>
                  </div>
                  <%}%>
                  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
                
            </div>

            <div class="col-md-6 d-flex flex-column justify-content-center align-items-center py-3">
                <h5 class="text-primary mb-3">Puntúa esta playa</h5>
                <div class="row justify-content-center mx-0">
                    <%for(int i=0; i<6; i++) {%>
                        <a href="Controller?op=vapuntos&puntos=<%=i%>&playa=<%=playa.getId()%>&user=<%=user.getId()%>"><img src="img/ic_<%=i%>.png" alt="" width="80" class="m-1"></a>
                    <%}%>
                </div>
                <h5 class="text-primary my-3">Media de puntos</h5>
                <div class="row justify-content-center mx-0">
                    <%if(mediaPuntos != null && mediaPuntos > 0) { %>
                    <div class="rating">
                        <img src="img/ic_<%=mediaPuntos%>.png" alt="rating" width="90" class="mb-2">
                    </div>
                    <%} else {%>
                    <div class="pb-2 font-italic">No existen puntos</div>
                    <%}%>
                </div>
            </div>
        </div>

        <footer>
            <h3 class="bg-primary text-white text-center py-3 mb-0">Playas &copy; Iván Gómez</h3>
        </footer>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>