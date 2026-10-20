<%@page import="entities.Usuario"%>
<%@page import="entities.Municipio"%>
<%@page import="entities.Provincia"%>
<%@page import="entities.Ccaa"%>
<%@page import="entities.Images"%>
<%@page import="java.util.List"%>
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
      
      <%List<Playa> playas = (List<Playa>)session.getAttribute("playas");
        List<Ccaa> comunidades = (List<Ccaa>)session.getAttribute("comunidades");
        List<Provincia> provincias = (List<Provincia>)session.getAttribute("provincias");
        List<Municipio> municipios = (List<Municipio>)session.getAttribute("municipios");
        Usuario user = (Usuario)session.getAttribute("user");
        String msg = (String)session.getAttribute("msg");
        session.removeAttribute("msg");
      %>
      
    <div class="container p-0 shadow d-flex flex-column min-vh-100">        
        <%if(msg!=null) {%>
            <div class="toast">
                <div class="toast-header">
                    <%=msg%>
                </div>
            </div>
        <%}%>
        
        <nav class="navbar navbar-expand-sm navbar-light bg-white sticky-top w-100">
            <a class="navbar-brand" href="Controller?op=inicio"><img src="img/logo.png" alt="" width="100px"></a>
            <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target="#collapsibleNavId" aria-controls="collapsibleNavId"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="collapsibleNavId">
                <div class="col-lg-12 col-md-4 col-sm-3">
                    <div class="row">
                        <form class="form-inline my-2 my-lg-0 ml-auto">
                            <%if(user==null) {%>
                                <button class="btn-login" type="button" data-toggle="modal" data-target="#modal">
                                    LOG IN 
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-circle mb-1 ml-1" viewBox="0 0 16 16">
                                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                    </svg>
                                </button>
                            <% } else { %>
                                <h4 class="mt-2 text-dark">Welcome <%=user.getNick()%></h4>
                                <a href="Controller?op=logout" class="btn-logout">LOG OUT<a/>
                            <% } %>
                        </form>
                    </div>
                    <div class="row">
                        <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                            <form action="Controller?op=vacomunidad" method="post">
                                <select name="selectcomunidad" id="comunidad" class="select ml-4" onchange="this.form.submit()">
                                    <option disabled selected="true">Elija una comunidad</option>
                                    <%if(comunidades!=null) {%>
                                        <%for(Ccaa comunidad : comunidades) {%>
                                            <option value="<%=comunidad.getId()%>"><%=comunidad.getNombre()%></option>
                                        <%}%>
                                    <%}%>
                                </select>
                            </form>
                            
                            <form action="Controller?op=vaprovincia" method="post">
                                <select name="selectprovincia" id="provincia" class="select ml-4" onchange="this.form.submit()">
                                    <option disabled selected="true">Elija una provincia</option>
                                    <%if(provincias!=null) {
                                        for(Provincia provincia : provincias) {%>
                                            <option value="<%=provincia.getId()%>"><%=provincia.getNombre()%></option>
                                        <% } %>
                                    <% } %>
                                </select>
                            </form>
                                
                            <form action="Controller?op=vamunicipio" method="post">
                                <select name="selectmunicipio" id="municipio" class="select ml-4" onchange="this.form.submit()">
                                    <option disabled selected="true">Elija un municipio</option>
                                    <%if(municipios!=null) {
                                        for(Municipio municipio : municipios) {%>
                                            <option value="<%=municipio.getId()%>"><%=municipio.getNombre()%></option>
                                        <% } %>
                                    <% } %>
                                </select>
                            </form>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
                  
        <!-- Modal LogIn -->
        <div class="modal fade" id="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Login & Register</h4>
                    </div>
                    <form action="Controller?op=login" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Nickname</label>
                                <input type="text" class="form-control" name="nick" id="nick" placeholder="Nickname">
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" class="form-control" name="pass" id="pass" placeholder="Password">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-circle mb-1" viewBox="0 0 16 16">
                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                </svg> LOGIN & REGISTER</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-x-circle mb-1" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                                </svg> CANCELAR</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%if(playas != null) {%>
        
            <%if(user==null) {%>
                <div class="row justify-content-center">
                    <%for(Playa playa : playas) {%>
                    <div class="col-md-6 d-flex">
                        <div class="card flex-fill m-3">
                            <%if(playa.getImagesList().isEmpty()) {%>
                                <div class="sin-foto card-img-top">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                                        <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                        <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
                                    </svg>
                                    <span>Sin foto disponible</span>
                                </div>
                            <%} else {%>
                                <img class="card-img-top" src="img/<%=playa.getId()%>_<%=playa.getImagesList().get(0).getId()%>.jpg" alt=""
                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                <div class="sin-foto card-img-top" style="display:none">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                                        <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                        <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
                                    </svg>
                                    <span>Sin foto disponible</span>
                                </div>
                            <%}%>
                            <div class="card-body p-2 m-2">
                                <h4 class="card-title"><%=playa.getNombre()%></h4>
                                <p class="card-text"><%=playa.getDescripcion()%></p>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } else {%>
                <div class="row justify-content-center">
                    <%for(Playa playa : playas) {%>
                    <div class="col-md-6 d-flex">
                        <div class="card flex-fill m-3">
                            <%if(playa.getImagesList().isEmpty()) {%>
                                <div class="sin-foto card-img-top">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                                        <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                        <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
                                    </svg>
                                    <span>Sin foto disponible</span>
                                </div>
                            <%} else {%>
                                <img class="card-img-top" src="img/<%=playa.getId()%>_<%=playa.getImagesList().get(0).getId()%>.jpg" alt=""
                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                <div class="sin-foto card-img-top" style="display:none">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                                        <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                        <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
                                    </svg>
                                    <span>Sin foto disponible</span>
                                </div>
                            <%}%>
                            <div class="card-body p-2 m-2">
                                <h4 class="card-title"><%=playa.getNombre()%></h4>
                                <p class="card-text mb-3"><%=playa.getDescripcion()%></p>
                            </div>
                            <div class="card-footer bg-white border-top-0">
                                <div class="row justify-content-center mb-0">
                                    <div class="col text-left">
                                        <a class="text-danger" data-toggle="modal" data-target="#modalRatings" data-nombreplaya="<%=playa.getNombre()%>" data-idplaya="<%=playa.getId()%>">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-info-circle-fill" viewBox="0 0 16 16">
                                                <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                                            </svg>
                                        </a>
                                    </div>   
                                    <div class="col text-right">
                                        <a class="text-warning" href="Controller?op=detail&playa=<%=playa.getId()%>">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                            </svg>
                                        </a>      
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>
        
                <% } else { %>
            <!-- Bienvenida -->
            <div class="text-white text-center d-flex flex-column justify-content-center"
                 style="min-height:320px; background: linear-gradient(rgba(0,0,0,.45), rgba(0,0,0,.45)), url('img/1_1.jpg') center/cover;">
                <h1 class="display-4 font-weight-bold">Descubre las playas de España</h1>
                <p class="lead mx-3">Busca por comunidad, provincia y municipio, consulta sus fotos y puntúalas.</p>
                <%if(user==null) {%>
                    <div>
                        <button class="btn btn-light mt-2" data-toggle="modal" data-target="#modal">Inicia sesión para puntuar</button>
                    </div>
                <%}%>
            </div>

            <!-- Cómo funciona -->
            <div class="row text-center mx-0 py-4">
                <div class="col-md-4 mb-3">
                    <h2 class="text-primary font-weight-bold">1</h2>
                    <h5>Elige una comunidad</h5>
                    <p class="text-muted small mb-0">Usa los desplegables o pulsa una bandera.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h2 class="text-primary font-weight-bold">2</h2>
                    <h5>Filtra por provincia y municipio</h5>
                    <p class="text-muted small mb-0">Verás todas las playas de la zona.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h2 class="text-primary font-weight-bold">3</h2>
                    <h5>Valora tus favoritas</h5>
                    <p class="text-muted small mb-0">Inicia sesión y puntúa de 0 a 5.</p>
                </div>
            </div>

            <!-- Acceso rápido por comunidad -->
            <%if(comunidades != null) {%>
            <div class="bg-light py-4 px-3">
                <h4 class="text-center mb-4">Explora por comunidad</h4>
                <form action="Controller?op=vacomunidad" method="post">
                    <div class="row justify-content-center mx-0">
                        <%for(Ccaa comunidad : comunidades) {%>
                        <div class="col-6 col-sm-4 col-md-3 mb-3">
                            <button type="submit" name="selectcomunidad" value="<%=comunidad.getId()%>"
                                    class="btn btn-white bg-white shadow-sm w-100 h-100 py-3">
                                <img src="img/ccaa_<%=comunidad.getId()%>.png" alt="" width="60" height="40"
                                     class="rounded mb-2" onerror="this.style.display='none'"><br>
                                <span class="small font-weight-bold"><%=comunidad.getNombre()%></span>
                            </button>
                        </div>
                        <%}%>
                    </div>
                </form>
            </div>
            <%}%>
        <% } %>
        
        <!-- Modal Ratings -->
            <div class="modal fade" id="modalRatings" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title text-center">Calificación de la playa</h3>
                            
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <h4 class="text-center">Nombre Playa</h4>
                            <div id="puntuacion">
                                    
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-success" data-dismiss="modal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-lg mr-1 mb-1" viewBox="0 0 16 16">
                                    <path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
                                    </svg>Aceptar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        <footer class="mt-auto">
            <h3 class="bg-primary text-white text-center py-3 mb-0">Playas &copy; Iván Gómez</h3>
        </footer>
    </div>
      
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script type="text/javascript">
        <%if(session.getAttribute("comunidad")!=null) {%>
            $('#comunidad').val('<%=session.getAttribute("comunidad") %>');
             <%if(session.getAttribute("provincia")!=null) {%>
                $('#provincia').val('<%=session.getAttribute("provincia") %>');
                 <%if(session.getAttribute("municipio")!=null) {%>
                    $('#municipio').val('<%=session.getAttribute("municipio") %>');
                 <%}
            }
        }%>
    </script>
    <%if(msg!=null) {%>
            <script>
                $(document).ready(function(){
                    $('.toast').toast('show');
                });
            </script>
    <%}%>
    <script src="myjs.js"></script>
  </body>
</html>
