# Cranbarry pie

Spoločný multiplayer projekt pre Alexa a kamaráta. Základ: **Godot 4 + GDScript + GitHub**.

Repozitár: https://github.com/Skyramp420/cranbarry-pie (Private).

## Čo už funguje

Projekt sa otvára cez `project.godot` a F6/F5 zobrazí úvodnú scénu. Používa Compatibility renderer a zatiaľ neobsahuje hernú mechaniku ani sieťové spojenie. Výber 2D alebo 3D zostáva otvorený.

## Prvé spustenie na oboch počítačoch

1. Nainštalujte si rovnakú stabilnú verziu [Godotu 4](https://godotengine.org/download/) (aspoň 4.4, štandardnú verziu pre GDScript), [Git](https://git-scm.com/downloads) a [Git LFS](https://git-lfs.com/).
2. Majiteľ pozve druhého človeka cez GitHub → Settings → Collaborators. Pozvaný musí pozvanie prijať, aby mohol klonovať súkromné repo.
3. V termináli spustite:

   ```sh
   git lfs install
   git clone https://github.com/Skyramp420/cranbarry-pie.git
   cd cranbarry-pie
   git lfs pull
   ```

4. V Godot Project Manageri zvoľte Import, vyberte `project.godot` a otvorte projekt. Stlačte **F5**.
5. Pred prvým vývojom zapíšte presné spoločné číslo verzie Godotu do tejto sekcie. Upgrade si dohodnite spolu.

GitHub Desktop môže nahradiť bežné príkazy Gitu. Projekt otvárajte z lokálnej kópie mimo synchronizovaných priečinkov OneDrive/Dropbox.

## Kam patria súbory

```text
assets/             modely, textúry, zvuky a hudba
scenes/main/        úvodná scéna
scenes/player/      scéna hráča
scenes/maps/        mapy
scenes/ui/          menu a lobby
scripts/player/    pohyb a ovládanie
scripts/networking/ sieťové spojenie
scripts/gameplay/  herné pravidlá
```

Prázdne priečinky držia súbory `.gitkeep`; pri pridaní obsahu ich môžete odstrániť.

## Jednoduchá spolupráca vo dvojici

`main` má obsahovať spustiteľný projekt. Každá menšia úloha má vlastnú krátkodobú vetvu a Pull Request do `main`. Vetvu `develop` zatiaľ nepotrebujete.

Pred novou úlohou s čistou pracovnou kópiou:

```sh
git switch main
git pull --ff-only
git switch -c feature/player-movement
```

Alex môže pracovať na `feature/player-movement`, kamarát na `feature/lobby`. Vopred si rozdeľte scény; neupravujte naraz rovnakú scénu, binárny asset ani `project.godot`.

Po malej dokončenej zmene:

```sh
git status
git add scenes/player/ scripts/player/
git commit -m "Add player movement"
git push -u origin feature/player-movement
```

Cesty v `git add` prispôsobte svojej úlohe. Skontrolujte, že pridávate aj nové súvisiace `.uid` a `.import` súbory. Na GitHube vytvorte Pull Request, popíšte zmenu a ako ste ju v Godote overili. Druhý človek zmenu skontroluje. Po kontrole použite **Squash and merge**, odstráňte vzdialenú vetvu a obaja aktualizujte `main`.

Ak sa `main` medzičasom zmenil, najprv uložte vlastnú prácu do commitu a vo svojej vetve spustite:

```sh
git fetch origin
git merge origin/main
```

Konflikty vyriešte spolu, znovu spustite projekt a pushnite výsledok. Nepoužívajte force push na `main`. Ak máte rozpracované zmeny, pred prepínaním vetiev ich commitnite alebo odložte cez stash.

## Git LFS a ignorované súbory

`.gitattributes` už obsahuje LFS pravidlá pre bežné binárne assety. Pred ich prvým pridaním musí mať každý nainštalované LFS. Ďalší formát pridáte napríklad cez `git lfs track "*.dds"` a commitnete aj upravený `.gitattributes`.

`git lfs ls-files` ukáže súbory v LFS. LFS používa samostatné úložisko a prenosové kvóty účtu; aktuálne podmienky skontrolujte pred pridávaním veľkých assetov v [GitHub dokumentácii](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage).

Textové `.gd`, `.tscn`, `.tres`, `.uid`, `.svg` a `project.godot` ponechávame v bežnom Gite, aby sa dali porovnávať a zlučovať. `.godot/`, exportované buildy a lokálne tajomstvá ignorujeme. Súbory `.uid` a `.import` commitujte; nie sú to priečinky importovanej cache.

Ďalšie informácie: [verziovanie projektov Godot](https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html).

## Prvé malé úlohy

1. Dohodnúť 2D/3D, žáner a jednu hlavnú hernú mechaniku.
2. Alex: pohyb jedného hráča v testovacej mape.
3. Kamarát: jednoduchá obrazovka lobby s Host/Join.
4. Spojiť dvoch hráčov v lokálnej sieti cez Godot High-Level Multiplayer API a ENet.
5. Overiť oba herné klienty na dvoch počítačoch; internetové pripojenie riešiť ako ďalšiu úlohu.

## Licencia a assety

Licenciu projektu zatiaľ nemáme vybranú. Pri každom externom assete si uchovajte zdroj a licenčné podmienky. Pred zverejnením alebo distribúciou hry si dohodnite vlastníctvo kódu a assetov aj licenciu.
