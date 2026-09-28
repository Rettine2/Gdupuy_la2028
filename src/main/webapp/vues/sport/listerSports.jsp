<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Liste des Sports | LA28 BETTING</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
  <style>
    :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --gold: #FFB800; --text: #fff; --muted: #9499ad; --border: #1f2129; }
    body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

    .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
    .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
    .logo span { color: var(--gold); }
    .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
    .nav-links a:hover, .nav-links a.active { color: var(--gold); text-shadow: 0 0 10px rgba(255,184,0,0.3); }

    .container { max-width: 1000px; margin: 50px auto; padding: 0 20px; }

    .header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; flex-wrap: wrap; gap: 20px; }
    .header-title { font-family: 'Teko', sans-serif; font-size: 4rem; text-transform: uppercase; margin: 0; letter-spacing: 1px; }

    .btn-cyber { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--bg); background: var(--gold); padding: 8px 25px; text-decoration: none; clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); font-weight: 700; transition: 0.3s; display: inline-block; }
    .btn-cyber:hover { opacity: 0.85; box-shadow: 0 0 15px rgba(255,184,0,0.4); transform: translateY(-2px); }

    .cyber-table-wrapper { background: var(--surface); border: 1px solid var(--border); overflow: hidden; }
    .cyber-table { width: 100%; border-collapse: collapse; text-align: left; }
    .cyber-table th { font-family: 'Teko', sans-serif; font-size: 1.5rem; letter-spacing: 1px; color: var(--muted); background: rgba(0,0,0,0.3); padding: 15px 25px; border-bottom: 1px solid var(--border); text-transform: uppercase; }
    .cyber-table td { padding: 18px 25px; border-bottom: 1px solid var(--border); font-size: 1rem; }
    .cyber-table tr { transition: 0.2s; }
    .cyber-table tr:hover { background: var(--surface-hover); }

    .sport-link { font-family: 'Teko', sans-serif; font-size: 2rem; color: var(--text); text-decoration: none; text-transform: uppercase; transition: 0.2s; display: inline-block; }
    .sport-link:hover { color: var(--gold); transform: translateX(5px); }
  </style>
</head>
<body>
<header class="topbar">
  <a href="../index.html" class="logo">LA28<span>BET</span></a>
  <div class="nav-links">
    <a href="../ServletAthlete/lister">Athlètes</a>
    <a href="../ServletEpreuve/lister">Épreuves</a>
    <a href="../ServletSite/lister">Sites</a>
    <a href="../ServletSport/lister" class="active">Sports</a>
    <a href="../ServletPays/lister">Pays</a>
  </div>
</header>

<div class="container">
  <div class="header-flex">
    <h1 class="header-title">Liste des Sports</h1>
    <a href="${pageContext.request.contextPath}/ServletSport/ajouter" class="btn-cyber">+ AJOUTER UN SPORT</a>
  </div>

  <div class="cyber-table-wrapper">
    <table class="cyber-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Nom du Sport</th>
      </tr>
      </thead>
      <tbody>
      <%
        ArrayList<Sport> lesSports = (ArrayList)request.getAttribute("pLesSports");
        if (lesSports != null) {
          for (Sport s : lesSports) {
      %>
      <tr>
        <td style="font-family: 'Teko', sans-serif; font-size: 1.4rem; color: var(--gold);"><%= s.getId() %></td>
        <td>
          <a href="../ServletSport/consulter?idSport=<%= s.getId() %>" class="sport-link">
            <%= s.getNom() %> ➔
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