<%--
    Document   : listerAthletes
    Created on : 25 août 2026, 12:27:51
    Author     : zakina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LOS ANGELES 2028</title>
</head>
<body>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LOS ANGELES 2028</title>
</head>
<body>
    <%
                Sport s = (Sport)request.getAttribute("pSport");
        %>
<h1><%  out.println(s.getNom());%></h1>


<table>
    <tr>
        <td>Id: </td><td><%  out.println(s.getId());%></td>
    </tr>
    <tr>
        <td>Sport : </td><td><%  out.println(s.getNom());%></td>
    </tr>
    <tr>
        <td>Athlete : </td><td><%
        for (Athlete a : s.getLesAthletes()) {
            out.println(a.getPrenom() + " " + a.getNom() + "<br>");
        }
    %></td>
    </tr>
</table>
</html>
