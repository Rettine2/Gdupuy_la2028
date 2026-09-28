<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%!
    public String getSportImageFilename(String sportName) {
        if (sportName == null) return "default";
        String name = sportName.trim().toLowerCase();
        if (name.contains("gymnastique")) return "gymnastique";
        return name.replaceAll("\\s+", "_");
    }

    public String getAthleteImageFilename(String prenom, String nom) {
        if (prenom == null || nom == null) return "default";
        String fullName = (prenom + " " + nom).trim();
        if (fullName.contains("Mélanie")) return "Mélanie_De_Jesus_dos_Santos";
        if (fullName.contains("Wout")) return "Wout_Van_Aert";
        if (fullName.contains("Diego")) return "Diego_Sebastián_Schwartzman";
        if (fullName.contains("Sydney")) return "Sydney_McLaughlin";
        return (prenom.trim() + "_" + nom.trim()).replaceAll("\\s+", "_");
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Sport | LA28 BETTING</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700;900&display=swap" rel="stylesheet">
    <style>
        :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --gold: #FFB800; --text: #fff; --muted: #9499ad; --border: #1f2129; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

        .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
        .logo span { color: var(--gold); }
        .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
        .nav-links a:hover, .nav-links a.active { color: var(--gold); text-shadow: 0 0 10px rgba(255,184,0,0.3); }

        .hero-sport { position: relative; width: 100%; height: 350px; border-bottom: 1px solid var(--gold); display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .hero-bg { position: absolute; width: 100%; height: 100%; object-fit: cover; opacity: 0.3; filter: grayscale(50%); z-index: 1; }
        .hero-overlay { position: absolute; inset: 0; background: linear-gradient(to top, var(--bg), transparent); z-index: 2; }

        .hero-content { position: relative; z-index: 3; text-align: center; }
        .hero-title { font-family: 'Teko', sans-serif; font-size: 6rem; line-height: 1; text-transform: uppercase; margin: 0; text-shadow: 0 10px 30px rgba(0,0,0,0.8); }
        .hero-id { display: inline-block; background: var(--gold); color: var(--bg); font-family: 'Teko', sans-serif; font-size: 1.5rem; padding: 5px 20px; clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); margin-top: 10px; font-weight: 700; }

        .container { max-width: 1200px; margin: 50px auto; padding: 0 20px; }
        .section-title { font-family: 'Teko', sans-serif; font-size: 3rem; text-transform: uppercase; margin-bottom: 30px; letter-spacing: 1px; color: var(--muted); border-bottom: 1px solid var(--border); padding-bottom: 10px; }

        .athlete-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .player-card { display: flex; align-items: center; gap: 20px; background: var(--surface); border: 1px solid var(--border); padding: 20px; text-decoration: none; color: var(--text); transition: 0.3s; border-left: 4px solid transparent; }
        .player-card:hover { background: var(--surface-hover); border-left-color: var(--gold); transform: translateX(5px); }

        .card-avatar { width: 70px; height: 70px; object-fit: cover; border-radius: 50%; border: 2px solid var(--border); }
        .player-card:hover .card-avatar { border-color: var(--gold); }

        .name-wrapper { display: flex; flex-direction: column; }
        .name-first { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); line-height: 0.9; text-transform: uppercase; }
        .name-last { font-family: 'Teko', sans-serif; font-size: 2.2rem; line-height: 1; text-transform: uppercase; }

        .empty-state { color: var(--muted); font-size: 1.2rem; font-style: italic; }
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

<% Sport s = (Sport)request.getAttribute("pSport"); %>

<div class="hero-sport">
    <img src="<%= request.getContextPath() %>/vues/image/<%= getSportImageFilename(s.getNom()) %>.jpg" class="hero-bg" onerror="this.style.opacity='0'">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1 class="hero-title"><%= s.getNom() %></h1>
        <div class="hero-id">SÉRIE / DISCIPLINE OFFICIELLE</div>
    </div>
</div>

<div class="container">
    <h2 class="section-title">Athlètes Engagés</h2>

    <div class="athlete-grid">
        <%
            if (s.getLesAthletes() != null && !s.getLesAthletes().isEmpty()) {
                for (Athlete a : s.getLesAthletes()) {
        %>
        <div class="player-card">
            <img src="<%= request.getContextPath() %>/vues/image/<%= getAthleteImageFilename(a.getPrenom(), a.getNom()) %>.jpg"
                 alt=""
                 class="card-avatar"
                 onerror="this.src='https://via.placeholder.com/70x70/1f2129/666A7A?text=LA28'">
            <div class="name-wrapper">
                <span class="name-first"><%= a.getPrenom() %></span>
                <span class="name-last"><%= a.getNom() %></span>
            </div>
        </div>
        <%      }
        } else {
        %>
        <div class="empty-state">Aucun athlète recensé dans cette discipline pour le moment.</div>
        <%  } %>
    </div>
</div>
</body>
</html>