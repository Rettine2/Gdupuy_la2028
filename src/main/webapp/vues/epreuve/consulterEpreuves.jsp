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
        <td>Athlètes participants : </td>
        <td>
            <%
                // On boucle sur la liste des athlètes
                if (e.getLesAthletes() != null && !e.getLesAthletes().isEmpty()) {
                    for (Athlete a : e.getLesAthletes()) {
                        out.println("- " + a.getPrenom() + " " + a.getNom() + "<br>");
                    }
                } else {
                    out.println("Aucun athlète n'est inscrit à cette épreuve.");
                }
            %>
        </td>
    </tr>
</table>

</body>
</html>