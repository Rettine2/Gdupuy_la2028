<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Roster Athlètes | LA28 BETTING</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --pink: #FF004D; --text: #fff; --muted: #9499ad; --border: #1f2129; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

        .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
        .logo span { color: var(--pink); }
        .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
        .nav-links a.active, .nav-links a:hover { color: var(--pink); text-shadow: 0 0 10px rgba(255,0,77,0.3); }

        .container { max-width: 1200px; margin: 50px auto; padding: 0 20px; }
        .header-title { font-family: 'Teko', sans-serif; font-size: 4rem; text-transform: uppercase; margin-bottom: 30px; letter-spacing: 1px; }

        .control-center { display: flex; gap: 15px; margin-bottom: 40px; }
        .cyber-input { flex: 1; background: var(--surface); border: 1px solid var(--border); color: var(--text); padding: 15px 20px; font-family: 'Inter', sans-serif; font-size: 1rem; outline: none; transition: 0.3s; clip-path: polygon(0 0, 100% 0, 100% calc(100% - 10px), calc(100% - 10px) 100%, 0 100%); }
        .cyber-input:focus { border-color: var(--pink); background: rgba(255,0,77,0.02); }

        /* Correction des listes déroulantes */
        select.cyber-input { cursor: pointer; }
        select.cyber-input option { background-color: var(--surface); color: var(--text); padding: 12px; }

        .athlete-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 20px; }
        .player-card { background: var(--surface); border: 1px solid var(--border); padding: 25px; text-decoration: none; color: var(--text); display: flex; flex-direction: column; justify-content: space-between; transition: 0.3s; border-top: 3px solid transparent; }
        .player-card:hover { background: var(--surface-hover); border-top-color: var(--pink); transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.5); }

        .card-top { display: flex; justify-content: space-between; margin-bottom: 20px; align-items: flex-start; }
        .tags { display: flex; flex-direction: column; gap: 5px; align-items: flex-end; }
        .tag { font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; padding: 4px 10px; background: var(--border); border-radius: 4px; }
        .tag.sport-cell { color: var(--pink); background: rgba(255,0,77,0.1); }
        .tag.pays-cell { color: var(--text); }

        .name { font-family: 'Teko', sans-serif; font-size: 2.5rem; line-height: 1; text-transform: uppercase; }
        .name span { display: block; font-weight: 400; font-size: 1.5rem; color: var(--muted); }

        .card-bottom { border-top: 1px solid var(--border); padding-top: 15px; display: flex; justify-content: space-between; align-items: center; }
        .meta { font-size: 0.85rem; color: var(--muted); }
        .action { font-family: 'Teko', sans-serif; font-size: 1.3rem; color: var(--pink); display: flex; align-items: center; gap: 5px; transition: 0.3s; }
        .player-card:hover .action { transform: translateX(5px); }
    </style>
</head>
<body>
<header class="topbar">
    <a href="../index.html" class="logo">LA28<span>BET</span></a>
    <div class="nav-links">
        <a href="../ServletAthlete/lister" class="active">Athlètes</a>
        <a href="../ServletEpreuve/lister">Épreuves</a>
    </div>
</header>

<div class="container">
    <h1 class="header-title">Database Joueurs</h1>

    <div class="control-center">
        <input type="text" id="searchInput" class="cyber-input" placeholder="NOM DU JOUEUR...">
        <select id="sportFilter" class="cyber-input"><option value="">TOUS LES SPORTS</option></select>
        <select id="paysFilter" class="cyber-input"><option value="">TOUS LES PAYS</option></select>
    </div>

    <div class="athlete-grid" id="athleteGrid">
        <% ArrayList<Athlete> lesAthletes = (ArrayList)request.getAttribute("pLesAthletes");
            for (Athlete a : lesAthletes) { %>
        <a href="../ServletAthlete/consulter?idAthlete=<%= a.getId() %>" class="player-card" data-nom="<%= a.getNom().toLowerCase() %>">
            <div class="card-top">
                <div class="name">
                    <span><%= a.getPrenom() %></span>
                    <%= a.getNom() %>
                </div>
                <div class="tags">
                    <div class="tag sport-cell"><%= a.getSport().getNom() %></div>
                    <div class="tag pays-cell"><%= a.getPays().getNom() %></div>
                </div>
            </div>
            <div class="card-bottom">
                <div class="meta">Né(e) en <%= a.getDateNaissance().format(DateTimeFormatter.ofPattern("yyyy")) %></div>
                <div class="action">ANALYSER ➔</div>
            </div>
        </a>
        <% } %>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const grid = document.getElementById('athleteGrid');
        const cards = Array.from(grid.querySelectorAll('.player-card'));

        // Tri alphabétique initial par nom de famille
        cards.sort((a, b) => a.getAttribute('data-nom').localeCompare(b.getAttribute('data-nom')));
        cards.forEach(card => grid.appendChild(card));

        const searchInput = document.getElementById('searchInput');
        const sportFilter = document.getElementById('sportFilter');
        const paysFilter = document.getElementById('paysFilter');
        let sports = new Set(), pays = new Set();

        cards.forEach(c => {
            sports.add(c.querySelector('.sport-cell').innerText);
            pays.add(c.querySelector('.pays-cell').innerText);
        });

        Array.from(sports).sort().forEach(s => sportFilter.add(new Option(s, s)));
        Array.from(pays).sort().forEach(p => paysFilter.add(new Option(p, p)));

        function filterCards() {
            const sVal = searchInput.value.toLowerCase(), spVal = sportFilter.value.toLowerCase(), pVal = paysFilter.value.toLowerCase();
            cards.forEach(c => {
                const match = c.querySelector('.name').innerText.toLowerCase().includes(sVal) &&
                    (spVal === "" || c.querySelector('.sport-cell').innerText.toLowerCase() === spVal) &&
                    (pVal === "" || c.querySelector('.pays-cell').innerText.toLowerCase() === pVal);
                c.style.display = match ? 'flex' : 'none';
            });
        }
        searchInput.addEventListener('input', filterCards);
        sportFilter.addEventListener('change', filterCards);
        paysFilter.addEventListener('change', filterCards);
    });
</script>
</body>
</html>