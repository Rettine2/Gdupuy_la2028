<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="sio.la2028.model.*"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Détails du Site | LA28 BETTING</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
  <style>
    :root { --bg: #050507; --surface: #0f1015; --cyan: #00F0FF; --text: #fff; --muted: #9499ad; --border: #1f2129; }
    body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

    .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
    .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
    .logo span { color: var(--cyan); }

    .site-hero { text-align: center; padding: 100px 20px; background: radial-gradient(circle at center, rgba(0,240,255,0.05) 0%, transparent 70%); border-bottom: 1px solid var(--border); }
    .city-label { font-family: 'Teko', sans-serif; color: var(--cyan); font-size: 1.8rem; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 10px; }
    .site-title { font-family: 'Teko', sans-serif; font-size: 6rem; line-height: 0.9; text-transform: uppercase; text-shadow: 0 10px 20px rgba(0,0,0,0.5); }

    .container { max-width: 900px; margin: 40px auto; padding: 0 20px; }
    .section-title { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--muted); border-bottom: 1px solid var(--border); padding-bottom: 10px; margin-bottom: 30px; text-transform: uppercase; }

    .event-list { display: flex; flex-direction: column; gap: 10px; }
    .event-row { display: flex; justify-content: space-between; align-items: center; background: var(--surface); padding: 20px 30px; border: 1px solid var(--border); transition: 0.2s; text-decoration: none; color: var(--text); border-left: 4px solid transparent; }
    .event-row:hover { background: #16181f; border-left-color: var(--cyan); transform: translateX(5px); }

    .event-name { font-family: 'Teko', sans-serif; font-size: 2rem; text-transform: uppercase; }
    .event-sport { font-size: 0.8rem; color: var(--cyan); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; display: block; margin-bottom: 5px; }
    .fake-odds { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--bg); background: var(--cyan); padding: 5px 25px; clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); font-weight: 700; transition: 0.3s; }
    .event-row:hover .fake-odds { box-shadow: 0 0 15px rgba(0,240,255,0.4); }

    .back-btn { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--text); text-decoration: none; display: inline-block; margin-top: 40px; padding: 10px 30px; border: 1px solid var(--border); transition: 0.3s; }
    .back-btn:hover { background: var(--text); color: var(--bg); }
  </style>
</head>
<body>
<header class="topbar">
  <a href="../index.html" class="logo">LA28<span>BET</span></a>
</header>

<% Site s = (Site)request.getAttribute("pSite"); %>

<div class="site-hero">
  <div class="city-label">/// <%= s.getVille() %> - <%= s.getPays().getNom() %></div>
  <h1 class="site-title"><%= s.getNom() %></h1>
</div>

<div class="container">
  <h2 class="section-title">Marchés disponibles sur ce site</h2>

  <div class="event-list">
    <%
      if (s.getLesEpreuves() != null && !s.getLesEpreuves().isEmpty()) {
        for (epreuve e : s.getLesEpreuves()) {
    %>
    <a href="../ServletEpreuve/consulter?idEpreuve=<%= e.getId() %>" class="event-row">
      <div>
        <span class="event-sport"><%= e.getSport().getNom() %></span>
        <div class="event-name"><%= e.getNom() %></div>
      </div>
      <div class="fake-odds">PARIER</div>
    </a>
    <%
      }
    } else {
    %>
    <div style="color: var(--muted); font-size: 1.2rem;">Aucun événement programmé sur ce site.</div>
    <%  } %>
  </div>

  <a href="../ServletSite/lister" class="back-btn">RETOUR AUX SITES</a>
</div>
</body>
</html>