<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%!
  public String getFilename(String code) {
    if (code == null) return "fr";
    switch (code.toUpperCase()) {
      case "FRA": return "fr";
      case "USA": return "us";
      case "ALG": return "dz";
      case "GER": return "de";
      case "ANT": return "ag";
      case "ARG": return "ar";
      case "AUS": return "au";
      case "AZE": return "az";
      case "BLR": return "by";
      case "BEL": return "be";
      case "ALB": return "al";
      default: return code.toLowerCase();
    }
  }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Détails Pays | LA28 BETTING</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
  <style>
    :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --purple: #BD00FF; --text: #fff; --muted: #9499ad; --border: #1f2129; }
    body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

    .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
    .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
    .logo span { color: var(--purple); }
    .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
    .nav-links a:hover, .nav-links a.active { color: var(--purple); text-shadow: 0 0 10px rgba(189,0,255,0.3); }

    .container { max-width: 900px; margin: 50px auto; padding: 0 20px; }
    .header-title { font-family: 'Teko', sans-serif; font-size: 4rem; text-transform: uppercase; margin-bottom: 30px; letter-spacing: 1px; display: flex; align-items: center; gap: 20px; }
    .country-flag-huge { width: 70px; height: auto; border-radius: 4px; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }

    .cyber-table-wrapper { background: var(--surface); border: 1px solid var(--border); overflow: hidden; margin-bottom: 30px; }
    .cyber-table { width: 100%; border-collapse: collapse; text-align: left; }
    .cyber-table th { font-family: 'Teko', sans-serif; font-size: 1.5rem; letter-spacing: 1px; color: var(--muted); background: rgba(0,0,0,0.3); padding: 15px 25px; border-bottom: 1px solid var(--border); text-transform: uppercase; }
    .cyber-table td { padding: 18px 25px; border-bottom: 1px solid var(--border); font-size: 1rem; }
    .cyber-table tr:hover { background: var(--surface-hover); }

    .back-btn { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--text); text-decoration: none; display: inline-block; padding: 10px 30px; border: 1px solid var(--border); transition: 0.3s; }
    .back-btn:hover { background: var(--text); color: var(--bg); }
  </style>
</head>
<body>
<header class="topbar">
  <a href="../index.html" class="logo">LA28<span>BET</span></a>
  <div class="nav-links">
    <a href="../ServletAthlete/lister">Athlètes</a>
    <a href="../ServletEpreuve/lister">Épreuves</a>
    <a href="../ServletSite/lister">Sites</a>
    <a href="../ServletSport/lister">Sports</a>
    <a href="../ServletPays/lister" class="active">Pays</a>
  </div>
</header>

<div class="container">
  <% Pays p = (Pays)request.getAttribute("pPays"); %>
  <h1 class="header-title">
    <% if(p != null && p.getCode() != null) { %>
    <img src="<%= request.getContextPath() %>/vues/image/<%= getFilename(p.getCode()) %>.png" alt="" class="country-flag-huge">
    <% } %>
    <%= p != null ? p.getNom() : "" %> (<%= p != null ? p.getCode() : "" %>)
  </h1>

  <div class="cyber-table-wrapper">
    <table class="cyber-table">
      <tr>
        <th style="width: 200px;">ID du Comité</th>
        <td><%= p != null ? p.getId() : "" %></td>
      </tr>
      <tr>
        <th>Nom du Pays</th>
        <td><%= p != null ? p.getNom() : "" %></td>
      </tr>
      <tr>
        <th>Code IOC</th>
        <td style="font-family: 'Teko', sans-serif; font-size: 1.4rem; color: var(--purple);"><%= p != null ? p.getCode() : "" %></td>
      </tr>
      <tr>
        <th>Athlètes Engagés</th>
        <td>
          <%
            if (p != null && p.getLesAthletes() != null && !p.getLesAthletes().isEmpty()) {
              for (Athlete a : p.getLesAthletes()) {
          %>
          <div style="padding: 5px 0;"><%= a.getPrenom() %> <strong><%= a.getNom() %></strong></div>
          <%
            }
          } else {
          %>
          <span style="color: var(--muted);">Aucun athlète recensé pour ce pays.</span>
          <% } %>
        </td>
      </tr>
    </table>
  </div>

  <a href="../ServletPays/lister" class="back-btn">RETOUR AUX PAYS</a>
</div>
</body>
</html>