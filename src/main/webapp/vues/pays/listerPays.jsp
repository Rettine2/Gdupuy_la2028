<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.util.ArrayList"%>
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
  <title>Délégations Pays | LA28 BETTING</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
  <style>
    :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --volt: #D5FF00; --text: #fff; --muted: #9499ad; --border: #1f2129; }
    body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

    .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
    .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
    .logo span { color: var(--volt); }
    .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
    .nav-links a:hover, .nav-links a.active { color: var(--volt); text-shadow: 0 0 10px rgba(213,255,0,0.3); }

    .container { max-width: 1000px; margin: 50px auto; padding: 0 20px; }
    .header-title { font-family: 'Teko', sans-serif; font-size: 4rem; text-transform: uppercase; margin-bottom: 40px; letter-spacing: 1px; }

    .country-table-wrapper { background: var(--surface); border: 1px solid var(--border); overflow: hidden; }
    .cyber-table { width: 100%; border-collapse: collapse; text-align: left; }
    .cyber-table th { font-family: 'Teko', sans-serif; font-size: 1.5rem; letter-spacing: 1px; color: var(--muted); background: rgba(0,0,0,0.3); padding: 15px 25px; border-bottom: 1px solid var(--border); text-transform: uppercase; }
    .cyber-table td { padding: 18px 25px; border-bottom: 1px solid var(--border); font-size: 1rem; }
    .cyber-table tr { transition: 0.2s; }
    .cyber-table tr:hover { background: var(--surface-hover); }

    .country-flag-cell { width: 80px; }
    .country-flag-img { width: 45px; height: auto; border-radius: 2px; box-shadow: 0 2px 5px rgba(0,0,0,0.4); display: block; }

    .country-code { font-family: 'Teko', sans-serif; font-size: 1.4rem; color: var(--volt); letter-spacing: 1px; }
    .country-link { font-family: 'Teko', sans-serif; font-size: 2rem; color: var(--text); text-decoration: none; text-transform: uppercase; transition: 0.2s; display: inline-block; }
    .country-link:hover { color: var(--volt); transform: translateX(5px); }
  </style>
</head>
<body>
<header class="topbar">
  <a href="../index.html" class="logo">LA28<span>BET</span></a>
  <div class="nav-links">
    <a href="../ServletAthlete/lister">Athlètes</a>
    <a href="../ServletEpreuve/lister">Épreuves</a>
    <a href="../ServletSite/lister">Sites</a>
    <a href="../ServletPays/lister" class="active">Pays</a>
  </div>
</header>

<div class="container">
  <h1 class="header-title">Délégations Officielles</h1>

  <div class="country-table-wrapper">
    <table class="cyber-table">
      <thead>
      <tr>
        <th>Drapeau</th>
        <th>Code IOC</th>
        <th>Pays / Comité</th>
      </tr>
      </thead>
      <tbody>
      <%
        ArrayList<Pays> lesPays = (ArrayList)request.getAttribute("pLesPays");
        if (lesPays != null) {
          for (Pays p : lesPays) {
      %>
      <tr>
        <td class="country-flag-cell">
          <% if(p.getCode() != null) { %>
          <img src="<%= request.getContextPath() %>/vues/image/<%= getFilename(p.getCode()) %>.png" alt="" class="country-flag-img">
          <% } %>
        </td>
        <td class="country-code"><%= p.getCode() %></td>
        <td>
          <a href="../ServletPays/consulter?idPays=<%= p.getId() %>" class="country-link">
            <%= p.getNom() %> ➔
          </a>
        </td>
      </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>