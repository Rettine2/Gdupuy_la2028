<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Lieux Olympiques | LA28 BETTING</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --cyan: #00F0FF; --text: #fff; --muted: #9499ad; --border: #1f2129; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

        .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
        .logo span { color: var(--cyan); }
        .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
        .nav-links a:hover, .nav-links a.active { color: var(--cyan); text-shadow: 0 0 10px rgba(0,240,255,0.3); }

        .container { max-width: 1200px; margin: 50px auto; padding: 0 20px; }
        .header-title { font-family: 'Teko', sans-serif; font-size: 4rem; text-transform: uppercase; margin-bottom: 40px; letter-spacing: 1px; }

        .site-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 25px; }
        .site-card { background: var(--surface); border: 1px solid var(--border); padding: 30px; text-decoration: none; color: var(--text); display: flex; flex-direction: column; transition: 0.3s; border-left: 4px solid var(--border); }
        .site-card:hover { background: var(--surface-hover); border-left-color: var(--cyan); transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.5); }

        .site-city { font-size: 0.8rem; text-transform: uppercase; letter-spacing: 2px; color: var(--cyan); font-weight: 600; margin-bottom: 5px; }
        .site-name { font-family: 'Teko', sans-serif; font-size: 2.5rem; line-height: 1; margin-bottom: 20px; text-transform: uppercase; }
        .site-country { display: inline-block; background: rgba(255,255,255,0.05); padding: 5px 12px; font-size: 0.8rem; border-radius: 4px; color: var(--muted); }

        .card-footer { margin-top: auto; padding-top: 20px; border-top: 1px solid var(--border); display: flex; justify-content: flex-end; }
        .action { font-family: 'Teko', sans-serif; font-size: 1.3rem; color: var(--text); display: flex; align-items: center; gap: 5px; transition: 0.3s; }
        .site-card:hover .action { color: var(--cyan); transform: translateX(5px); }
    </style>
</head>
<body>
<header class="topbar">
    <a href="../index.html" class="logo">LA28<span>BET</span></a>
    <div class="nav-links">
        <a href="../ServletAthlete/lister">Athlètes</a>
        <a href="../ServletEpreuve/lister">Épreuves</a>
        <a href="../ServletSite/lister" class="active">Sites</a>
    </div>
</header>

<div class="container">
    <h1 class="header-title">Arènes Olympiques</h1>

    <div class="site-grid">
        <% ArrayList<Site> lesSites = (ArrayList)request.getAttribute("pLesSites");
            for (Site s : lesSites) { %>
        <a href="../ServletSite/consulter?idSite=<%= s.getId() %>" class="site-card">
            <div class="site-city">/// <%= s.getVille() %></div>
            <div class="site-name"><%= s.getNom() %></div>
            <div><span class="site-country">🌍 <%= s.getPays().getNom() %></span></div>

            <div class="card-footer">
                <div class="action">AFFICHER LES ÉPREUVES ➔</div>
            </div>
        </a>
        <% } %>
    </div>
</div>
</body>
</html>