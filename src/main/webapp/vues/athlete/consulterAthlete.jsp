<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Profil Athlète | LA28 BETTING</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700;900&display=swap" rel="stylesheet">
    <style>
        :root { --bg: #050507; --surface: #0f1015; --pink: #FF004D; --text: #fff; --border: #1f2129; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

        .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.9); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
        .logo span { color: var(--pink); }

        .container { max-width: 900px; margin: 60px auto; padding: 0 20px; }

        .player-card-huge { background: var(--surface); border: 1px solid var(--border); padding: 50px; position: relative; overflow: hidden; }
        .player-card-huge::after { content: ''; position: absolute; bottom: 0; right: 0; width: 300px; height: 300px; background: radial-gradient(circle, rgba(255,0,77,0.15) 0%, transparent 70%); }

        .player-header { display: flex; justify-content: space-between; align-items: flex-end; border-bottom: 2px solid var(--border); padding-bottom: 20px; margin-bottom: 40px; position: relative; z-index: 2; }
        .names { display: flex; flex-direction: column; }
        .first-name { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: #666A7A; line-height: 0.8; text-transform: uppercase; }
        .last-name { font-family: 'Teko', sans-serif; font-size: 6rem; font-weight: 900; line-height: 0.9; text-transform: uppercase; color: var(--text); }

        .country-tag { background: var(--text); color: var(--bg); font-family: 'Teko', sans-serif; font-size: 2rem; padding: 5px 20px; text-transform: uppercase; clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); }

        .data-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; position: relative; z-index: 2; }
        .data-box { border: 1px solid var(--border); padding: 25px; background: rgba(5,5,7,0.5); }
        .data-label { font-size: 0.8rem; color: #666A7A; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px; font-weight: 600; }
        .data-value { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--pink); line-height: 1; text-transform: uppercase; }

        .back-btn { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--text); text-decoration: none; display: inline-block; margin-top: 40px; padding: 10px 30px; border: 1px solid var(--border); transition: 0.3s; }
        .back-btn:hover { background: var(--text); color: var(--bg); }
    </style>
</head>
<body>
<header class="topbar">
    <a href="../index.html" class="logo">LA28<span>BET</span></a>
</header>

<div class="container">
    <% Athlete a = (Athlete)request.getAttribute("pAthlete"); %>

    <div class="player-card-huge">
        <div class="player-header">
            <div class="names">
                <span class="first-name"><%= a.getPrenom() %></span>
                <span class="last-name"><%= a.getNom() %></span>
            </div>
            <div class="country-tag"><%= a.getPays().getNom() %></div>
        </div>

        <div class="data-grid">
            <div class="data-box">
                <div class="data-label">Discipline / Spécialité</div>
                <div class="data-value"><%= a.getSport().getNom() %></div>
            </div>
            <div class="data-box">
                <div class="data-label">Date de Naissance</div>
                <div class="data-value" style="color: var(--text);"><%= a.getDateNaissance().format(DateTimeFormatter.ofPattern("dd.MM.yyyy")) %></div>
            </div>
        </div>
    </div>

    <a href="../ServletAthlete/lister" class="back-btn">RETOUR AU ROSTER</a>
</div>
</body>
</html>