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
                Pays p = (Pays)request.getAttribute("pPays");
        %>
<h1><%  out.println(p.getNom());%><%  out.println(p.getCode());%></h1>


<table>
  <tr>
    <td>Id: </td><td><%  out.println(p.getId());%></td>
  </tr>
  <tr>
    <td>Pays : </td><td><%  out.println(p.getNom());%></td>
  </tr>
  <tr>
    <td>code : </td><td><%  out.println(p.getCode());%></td>
  </tr>
</table>
</html>
