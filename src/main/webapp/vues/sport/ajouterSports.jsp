<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Sport | LA28 BETTING</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Teko:wght@500;700&display=swap" rel="stylesheet">
    <style>
        :root { --bg: #050507; --surface: #0f1015; --gold: #FFB800; --text: #fff; --muted: #9499ad; --border: #1f2129; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding-bottom: 60px; }

        .topbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 50px; background: rgba(5,5,7,0.95); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; backdrop-filter: blur(10px); }
        .logo { font-family: 'Teko', sans-serif; font-size: 2.5rem; color: var(--text); text-decoration: none; line-height: 1; }
        .logo span { color: var(--gold); }
        .nav-links a { font-family: 'Teko', sans-serif; font-size: 1.5rem; color: var(--muted); text-decoration: none; margin-left: 30px; transition: 0.3s; text-transform: uppercase; }
        .nav-links a:hover, .nav-links a.active { color: var(--gold); text-shadow: 0 0 10px rgba(255,184,0,0.3); }

        .container { max-width: 600px; margin: 60px auto; padding: 0 20px; }
        .header-title { font-family: 'Teko', sans-serif; font-size: 3.5rem; text-transform: uppercase; margin-bottom: 30px; letter-spacing: 1px; border-bottom: 1px solid var(--border); padding-bottom: 15px; }

        .form-card { background: var(--surface); border: 1px solid var(--border); padding: 40px; border-top: 4px solid var(--gold); box-shadow: 0 15px 35px rgba(0,0,0,0.5); }
        .form-group { margin-bottom: 25px; display: flex; flex-direction: column; gap: 8px; }
        .form-label { font-size: 0.85rem; color: var(--muted); text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; }

        .cyber-input { background: rgba(5,5,7,0.8); border: 1px solid var(--border); color: var(--text); padding: 14px 18px; font-family: 'Inter', sans-serif; font-size: 1rem; outline: none; transition: 0.3s; }
        .cyber-input:focus { border-color: var(--gold); background: rgba(255,184,0,0.02); }

        input[type="file"] { padding: 10px; cursor: pointer; color: var(--muted); }

        .btn-submit { font-family: 'Teko', sans-serif; font-size: 1.6rem; color: var(--bg); background: var(--gold); width: 100%; padding: 12px; border: none; cursor: pointer; clip-path: polygon(10px 0, 100% 0, calc(100% - 10px) 100%, 0 100%); font-weight: 700; transition: 0.3s; text-transform: uppercase; margin-top: 10px; }
        .btn-submit:hover { opacity: 0.9; box-shadow: 0 0 20px rgba(255,184,0,0.4); }

        .back-btn { font-family: 'Teko', sans-serif; font-size: 1.4rem; color: var(--muted); text-decoration: none; display: inline-block; margin-top: 25px; transition: 0.3s; }
        .back-btn:hover { color: var(--text); }
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
    <h1 class="header-title">Nouveau Sport</h1>

    <div class="form-card">
        <form action="../ServletSport/ajouter" method="POST" enctype="multipart/form-data">

            <div class="form-group">
                <label class="form-label">Nom du Sport / Discipline</label>
                <input type="text" name="nomSport" class="cyber-input" placeholder="Ex: Escalade Sportive" required>
            </div>

            <div class="form-group">
                <label class="form-label">Nom du Pays associé (Optionnel)</label>
                <input type="text" name="nomPays" class="cyber-input" placeholder="Ex: France">
            </div>

            <div class="form-group">
                <label class="form-label">Code du Pays (Optionnel)</label>
                <input type="text" name="codePays" class="cyber-input" placeholder="Ex: FRA" maxlength="3">
            </div>

            <div class="form-group">
                <label class="form-label">Drapeau / Illustration (Dossier image)</label>
                <input type="file" name="imageSport" class="cyber-input">
            </div>

            <button type="submit" class="btn-submit">VALIDER ET ENREGISTRER</button>
        </form>
    </div>

    <a href="../ServletSport/lister" class="back-btn">← RETOUR À LA LISTE DES SPORTS</a>
</div>
</body>
</html>