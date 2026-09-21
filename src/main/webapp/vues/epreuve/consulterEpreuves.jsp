<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Matchup Épreuve | LA28 BETTING</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg: #050507; --surface: #0f1015; --volt: #D5FF00; --pink: #FF004D; --text: #fff; --muted: #9499ad; --border: #1f2129; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

        .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
        .logo span { color: var(--volt); }

        .matchup-hero { text-align: center; padding: 80px 20px; background: radial-gradient(circle at center, rgba(213,255,0,0.05) 0%, transparent 70%); border-bottom: 1px solid var(--border); }
        .sport-label { font-family: 'Teko', sans-serif; color: var(--volt); font-size: 1.5rem; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 10px; }
        .matchup-title { font-family: 'Teko', sans-serif; font-size: 5rem; line-height: 0.9; text-transform: uppercase; text-shadow: 0 10px 20px rgba(0,0,0,0.5); }

        .container { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .section-title { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--muted); border-bottom: 1px solid var(--border); padding-bottom: 10px; margin-bottom: 30px; text-transform: uppercase; }

        .fighter-list { display: flex; flex-direction: column; gap: 10px; }
        .fighter-row { display: flex; justify-content: space-between; align-items: center; background: var(--surface); padding: 15px 30px; border: 1px solid var(--border); transition: 0.2s; cursor: pointer; }
        .fighter-row:hover { background: #16181f; border-color: var(--volt); transform: translateX(5px); }
        .fighter-name { font-family: 'Teko', sans-serif; font-size: 2rem; text-transform: uppercase; }
        .fighter-name span { color: var(--muted); font-size: 1.2rem; margin-right: 10px; }
        .fake-odds { font-family: 'Teko', sans-serif; font-size: 1.3rem; color: var(--bg); background: var(--volt); padding: 3px 15px; clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); font-weight: 700; }

        .back-btn { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--text); text-decoration: none; display: inline-block; margin-top: 40px; padding: 10px 30px; border: 1px solid var(--border); transition: 0.3s; }
        .back-btn:hover { background: var(--text); color: var(--bg); }

        /* DESIGN CORRIGÉ DU POPUP (ESPACEMENT ET LISIBILITÉ) */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(5,5,7,0.85); backdrop-filter: blur(8px); z-index: 1000; justify-content: center; align-items: center; }
        .modal-card { background: var(--surface); border: 1px solid var(--pink); width: 440px; padding: 45px 35px; position: relative; box-shadow: 0 25px 50px rgba(0,0,0,0.8); }
        .modal-card::before { content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; background: var(--pink); }
        .modal-close { position: absolute; top: 15px; right: 20px; font-size: 2rem; color: var(--muted); cursor: pointer; transition: 0.2s; background: none; border: none; line-height: 1; }
        .modal-close:hover { color: var(--text); }

        .modal-header-block { margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid var(--border); }
        .modal-prenom { font-family: 'Teko', sans-serif; font-size: 1.8rem; color: var(--muted); line-height: 1; text-transform: uppercase; }
        .modal-nom { font-family: 'Teko', sans-serif; font-size: 3.5rem; font-weight: 700; line-height: 1.1; text-transform: uppercase; color: var(--text); margin-top: 2px; }

        .modal-info-group { display: flex; flex-direction: column; gap: 20px; }
        .modal-info-item { display: flex; flex-direction: column; gap: 4px; }
        .modal-label { font-size: 0.75rem; color: var(--muted); text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; }
        .modal-val { font-family: 'Teko', sans-serif; font-size: 1.8rem; color: var(--pink); line-height: 1.1; text-transform: uppercase; }
    </style>
</head>
<body>
<header class="topbar">
    <a href="../index.html" class="logo">LA28<span>BET</span></a>
</header>

<% epreuve e = (epreuve)request.getAttribute("pEpreuve"); %>

<div class="matchup-hero">
    <% if (e.getSport() != null) { %><div class="sport-label">/// <%= e.getSport().getNom() %></div><% } %>
    <h1 class="matchup-title"><%= e.getNom() %></h1>
</div>

<div class="container">
    <h2 class="section-title">Contenders</h2>
    <div class="fighter-list">
        <%
            if (e.getLesAthletes() != null && !e.getLesAthletes().isEmpty()) {
                for (Athlete a : e.getLesAthletes()) {
                    String dateNaiss = "";
                    if (a.getDateNaissance() != null) {
                        dateNaiss = a.getDateNaissance().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
                    }
        %>
        <div class="fighter-row" onclick="openModal('<%= a.getPrenom() %>', '<%= a.getNom() %>', '<%= a.getPays().getNom() %>', '<%= a.getSport().getNom() %>', '<%= dateNaiss %>')">
            <div class="fighter-name"><span><%= a.getPrenom() %></span><%= a.getNom() %></div>
            <div class="fake-odds">+ FICHE PROFIL</div>
        </div>
        <%
            }
        } else {
        %>
        <div style="color: var(--muted);">Marché fermé. Aucun athlète aligné.</div>
        <%  } %>
    </div>

    <a href="../ServletEpreuve/lister" class="back-btn">RETOUR AU LOBBY</a>
</div>

<!-- STRUCTURE DU POPUP PROPRE ET AÉRÉ -->
<div id="athleteModal" class="modal-overlay" onclick="closeModal()">
    <div class="modal-card" onclick="event.stopPropagation()">
        <button class="modal-close" onclick="closeModal()">&times;</button>

        <div class="modal-header-block">
            <div class="modal-prenom" id="mPrenom"></div>
            <div class="modal-nom" id="mNom"></div>
        </div>

        <div class="modal-info-group">
            <div class="modal-info-item">
                <div class="modal-label">Délégation / Pays</div>
                <div class="modal-val" id="mPays" style="color: var(--text);"></div>
            </div>
            <div class="modal-info-item">
                <div class="modal-label">Discipline Sportive</div>
                <div class="modal-val" id="mSport"></div>
            </div>
            <div class="modal-info-item">
                <div class="modal-label">Date de Naissance</div>
                <div class="modal-val" id="mDate" style="color: #fff; font-size: 1.5rem;"></div>
            </div>
        </div>
    </div>
</div>

<script>
    function openModal(prenom, nom, pays, sport, dateN) {
        document.getElementById('mPrenom').innerText = prenom;
        document.getElementById('mNom').innerText = nom;
        document.getElementById('mPays').innerText = pays;
        document.getElementById('mSport').innerText = sport;
        document.getElementById('mDate').innerText = dateN;
        document.getElementById('athleteModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('athleteModal').style.display = 'none';
    }
</script>
</body>
</html>