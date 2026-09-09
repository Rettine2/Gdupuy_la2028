<%--
  Created by IntelliJ IDEA.
  User: sio2
  Date: 09/09/2026
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>LOS ANGELES 2028</title>
  <link rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
        integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
        crossorigin="anonymous">

  <title>LOS ANGELES 2028</title>

  <style>
    body {
      padding-top: 50px;
    }
    .special {
      padding-top:50px;
    }
  </style>
</head>

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <a  href ='../ServletPays/lister' class="navbar-brand" href=".">Système de gestion des Pays</a>
    </div>
  </div>
</nav>
<body>
<div class="container special">
  <h2 class="h2">Liste des pays</h2>
  <div class="table-responsive">
    <%
      ArrayList<Pays> lesPays = (ArrayList)request.getAttribute("pLesPays");
    %>
    <table class="table table-striped table-sm">
      <thead>
      <tr>
        <th>id</th>
        <th>nom</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <%
          for (Pays p : lesPays)
          {
            out.println("<tr><td>");
            out.println(p.getId());
            out.println("</td>");

            out.println("<td>");
            out.println(p.getCode());
            out.println("</td>");

            out.println("<td>");
            out.println(p.getNom());
            out.println("</td>");
          }
        %>
      </tr>
      </tbody>
    </table>

  </div>
</div>
</body>
</html>

