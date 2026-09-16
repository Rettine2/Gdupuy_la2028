<%--
  Created by IntelliJ IDEA.
  User: sio2
  Date: 16/09/2026
  Time: 09:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="sio.la2028.model.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LOS ANGELES 2028</title>
</head>
<body>
<%
    // On récupère l'épreuve passée par la Servlet
    epreuve e = (epreuve)request.getAttribute("pEpreuve");
%>

<h1><% out.println(e.getNom()); %></h1>

<table>
    <tr>
        <td>Id : </td><td><% out.println(e.getId()); %></td>
    </tr>
    <tr>
        <td>Nom de l'épreuve : </td><td><% out.println(e.getNom()); %></td>
    </tr>
    <tr>
        <td>Sport associé : </td>
        <td>
            <%
                if (e.getSport() != null) {
                    out.println(e.getSport().getNom());
                }
            %>
        </td>
    </tr>
    <tr>
        <td>Athlète : </td>
        <td>
            <%
                // On affiche le prénom et le nom de l'athlète lié à l'épreuve
                if (e.getAthlete() != null) {
                    out.println(e.getAthlete().getPrenom() + " " + e.getAthlete().getNom());
                }
            %>
        </td>
    </tr>
</table>

</body>
</html>
