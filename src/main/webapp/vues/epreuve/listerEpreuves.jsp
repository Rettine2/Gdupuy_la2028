<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sio.la2028.model.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Lobby Épreuves | LA28 BETTING</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
  <style>
    :root { --bg: #050507; --surface: #0f1015; --surface-hover: #16181f; --volt: #D5FF00; --text: #fff; --muted: #9499ad; --border: #1f2129; }
    body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

    .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
    .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
    .logo span { color: var(--volt); }
    .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
    .nav-links a.active, .nav-links a:hover { color: var(--volt); text-shadow: 0 0 10px rgba(213,255,0,0.3); }

    .container { max-width: 1200px; margin: 50px auto; padding: 0 20px; }
    .header-title { font-family: 'Teko', sans-serif; font-size: 4rem; text-transform: uppercase; margin-bottom: 30px; letter-spacing: 1px; }

    .control-center { display: flex; gap: 20px; margin-bottom: 40px; }
    .cyber-input { flex: 1; background: var(--surface); border: 1px solid var(--border); color: var(--text); padding: 15px 20px; font-family: 'Inter', sans-serif; font-size: 1rem; outline: none; transition: 0.3s; clip-path: polygon(0 0, 100% 0, 100% calc(100% - 10px), calc(100% - 10px) 100%, 0 100%); }
    .cyber-input:focus { border-color: var(--volt); background: rgba(213,255,0,0.02); }

    /* Correction indispensable pour les listes déroulantes */
    select.cyber-input { cursor: pointer; }
    select.cyber-input option { background-color: var(--surface); color: var(--text); padding: 12px; }

    .bet-list { display: flex; flex-direction: column; gap: 10px; }
    .bet-row { display: flex; justify-content: space-between; align-items: center; background: var(--surface); padding: 20px 30px; border: 1px solid var(--border); transition: 0.2s; text-decoration: none; color: var(--text); border-left: 4px solid transparent; }
    .bet-row:hover { background: var(--surface-hover); border-left-color: var(--volt); transform: translateX(5px); }

    .bet-info { display: flex; flex-direction: column; gap: 5px; }
    .event-name { font-family: 'Teko', sans-serif; font-size: 2rem; line-height: 1; letter-spacing: 0.5px; }
    .sport-tag { font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1.5px; color: var(--volt); font-weight: 600; display: flex; align-items: center; gap: 8px; }
    .sport-tag::before { content: ''; width: 6px; height: 6px; background: var(--volt); border-radius: 50%; }

    .bet-action { font-family: 'Teko', sans-serif; font-size: 1.5rem; background: var(--border); padding: 5px 30px; color: var(--text); clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); transition: 0.3s; }
    .bet-row:hover .bet-action { background: var(--volt); color: var(--bg); box-shadow: 0 0 15px rgba(213,255,0,0.4); }
  </style>
</head>
<body>
<header class="topbar">
  <a href="../index.html" class="logo">LA28<span>BET</span></a>
  <div class="nav-links">
    <a href="../ServletAthlete/lister">Athlètes</a>
    <a href="../ServletEpreuve/lister" class="active">Épreuves</a>
  </div>
</header>

<div class="container">
  <h1 class="header-title">Marchés Ouverts</h1>

  <div class="control-center">
    <input type="text" id="searchInput" class="cyber-input" placeholder="RECHERCHER UNE COMPÉTITION...">
    <select id="sportFilter" class="cyber-input" style="flex: 0.5;"><option value="">TOUS LES SPORTS</option></select>
  </div>

  <div class="bet-list" id="epreuveList">
    <% ArrayList<epreuve> lesEpreuves = (ArrayList)request.getAttribute("pLesEpreuves");
      for (epreuve e : lesEpreuves) { %>
    <a href="../ServletEpreuve/consulter?idEpreuve=<%= e.getId() %>" class="bet-row">
      <div class="bet-info">
        <span class="sport-tag sport-cell"><%= e.getSport().getNom() %></span>
        <span class="event-name"><%= e.getNom() %></span>
      </div>
      <div class="bet-action">COTES & INFOS</div>
    </a>
    <% } %>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('.bet-row');
    const searchInput = document.getElementById('searchInput');
    const sportFilter = document.getElementById('sportFilter');
    let sports = new Set();
    rows.forEach(row => sports.add(row.querySelector('.sport-cell').innerText));
    Array.from(sports).sort().forEach(sport => sportFilter.add(new Option(sport, sport)));

    function filterTable() {
      const sVal = searchInput.value.toLowerCase(), spVal = sportFilter.value.toLowerCase();
      rows.forEach(row => {
        const match = row.querySelector('.event-name').innerText.toLowerCase().includes(sVal) &&
                (spVal === "" || row.querySelector('.sport-cell').innerText.toLowerCase() === spVal);
        row.style.display = match ? 'flex' : 'none';
      });
    }
    searchInput.addEventListener('input', filterTable); sportFilter.addEventListener('change', filterTable);
  });
</script>
</body>
</html>