<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="sio.la2028.model.*"%>
<%!
  public String getSiteImageFilename(String siteName) {
    if (siteName == null) return "default";
    String name = siteName.trim().toLowerCase();
    if (name.contains("sofi")) return "sofi";
    if (name.contains("memorial") || name.contains("coliseum")) return "lamemorial";
    if (name.contains("santa monica")) return "santamonica";
    if (name.contains("crypto")) return "crypto";
    if (name.contains("dignity")) return "dignity";
    return name.replaceAll("\\s+", "_");
  }
%>
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
    .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
    .nav-links a:hover, .nav-links a.active { color: var(--cyan); text-shadow: 0 0 10px rgba(0,240,255,0.3); }

    .container { max-width: 950px; margin: 50px auto; padding: 0 20px; }

    /* CARTE CENTRALE STRUCTURÉE PROPRE */
    .site-card-huge { background: var(--surface); border: 1px solid var(--border); padding: 40px; position: relative; overflow: hidden; border-top: 4px solid var(--cyan); box-shadow: 0 15px 35px rgba(0,0,0,0.5); }
    .site-header { display: flex; align-items: center; gap: 30px; flex-wrap: wrap; }
    .site-img-box { width: 220px; height: 140px; object-fit: cover; border: 2px solid var(--cyan); box-shadow: 0 0 20px rgba(0,240,255,0.3); border-radius: 4px; flex-shrink: 0; background: #16181f; }

    .site-meta { display: flex; flex-direction: column; min-width: 0; flex: 1; }
    .city-label { font-family: 'Teko', sans-serif; font-size: 1.8rem; color: var(--cyan); text-transform: uppercase; line-height: 1; margin-bottom: 5px; }
    .site-title-huge { font-family: 'Teko', sans-serif; font-size: clamp(2.5rem, 4vw, 4.5rem); font-weight: 700; color: var(--text); line-height: 0.95; text-transform: uppercase; word-break: break-word; margin: 0; }
    .country-badge { display: inline-block; margin-top: 12px; background: rgba(255,255,255,0.05); border: 1px solid var(--border); padding: 5px 15px; font-size: 0.85rem; color: var(--muted); border-radius: 4px; width: fit-content; }

    .section-title { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--muted); border-bottom: 1px solid var(--border); padding-bottom: 10px; margin: 50px 0 25px 0; text-transform: uppercase; }

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
  <div class="nav-links">
    <a href="../ServletAthlete/lister">Athlètes</a>
    <a href="../ServletEpreuve/lister">Épreuves</a>
    <a href="../ServletSite/lister" class="active">Sites</a>
    <a href="../ServletSport/lister">Sports</a>
    <a href="../ServletPays/lister">Pays</a>
  </div>
</header>

<% Site s = (Site)request.getAttribute("pSite"); %>

<div class="container">
  <div class="site-card-huge">
    <div class="site-header">
      <img src="<%= request.getContextPath() %>/vues/image/<%= getSiteImageFilename(s.getNom()) %>.jpg" alt="<%= s.getNom() %>" class="site-img-box" onerror="this.style.display='none'">
      <div class="site-meta">
        <span class="city-label">/// <%= s.getVille() %></span>
        <h1 class="site-title-huge"><%= s.getNom() %></h1>
        <div><span class="country-badge">🌍 Comité / Pays : <%= s.getPays().getNom() %></span></div>
      </div>
    </div>
  </div>

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