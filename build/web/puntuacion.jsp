<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<%
    List<Short> puntuacion = (List<Short>)session.getAttribute("puntuacion");
    if(puntuacion.size() == 0) {%>
        <h3 class="text-center my-4">Playa sin puntuaciones</h3>
    <%} else {%>
        <table class="table table-striped my-3">
            <%for(int i = 0; i < puntuacion.size(); i++) {%>
            <tr>
                <td class="text-right col-6 pr-5"><img src="img/ic_<%=i+1%>.png" alt="" width="50px"></td>
                <td class="text-left col-6 pl-5 pt-4"><%=puntuacion.get(i)%></td>
            </tr>
            <%}%>
        </table>
    <%}%>