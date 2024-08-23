# moba-manager
 
### Gameplay Loop

1. **MOBA Kampe (Idle Loop):**
   - **Kampens Varighed:** Hver kamp varer 15 minutter.
   - **Automatisering:** Kampe køres automatisk mod AI-modstandere, hvor spillerens hold (som består af de helte, de har opgraderet) kæmper mod fjendtlige hold.
   - **Resultatberegning:** Når kampen er afsluttet, genereres et resultat baseret på de kombinerede styrker og svagheder i holdet og AI'ens hold. Vælg tilfældige faktorer som kritiske hits, bonusser eller uventede begivenheder, der kan påvirke udfaldet.

2. **Belønninger (Loot og XP):**
   - **XP og Leveling:** XP gives baseret på kampens udfald, hvor en sejr giver mere XP end et nederlag. XP bruges til at opgradere heltenes niveauer, som kan forbedre deres stats og evner.
   - **Loot:** Spillere modtager loot baseret på kampens sværhedsgrad og resultat. Loot kan omfatte crafting materialer, genstande, eller mønter (eller gummiænder, i jeres tilfælde).
   - **Tilfældige Belønninger:** Introducer en lille chance for sjældne eller unikke belønninger, som spillere kun kan få gennem bestemte handlinger eller ved at vinde flere kampe i træk.

3. **Progression:**
   - **Helteopgradering:** Spillere bruger XP og loot til at opgradere deres helte, enten ved at forbedre stats direkte eller ved at udstyre dem med bedre genstande.
   - **Crafting:** Loot kan bruges til at crafte nye genstande eller opgradere eksisterende genstande, som heltene kan udstyres med for at øge deres styrke i fremtidige kampe.
   - **Hold Management:** Spillere kan administrere og tilpasse deres hold, vælge hvilke helte der skal bruges i kampe, og hvilke genstande der skal tildeles dem.

4. **Idle Gameplay Flow:**
   - **15-Minute Loop:** Efter hver kamp får spilleren en rapport om kampens udfald, hvor de kan se resultaterne, indsamle belønninger, og forberede sig til den næste kamp.
   - **Active Decision Making:** Mens kampene kører automatisk, skal spilleren stadig aktivt vælge og opgradere deres hold og items for at maksimere deres chancer for sejr.

### Beregning af Belønninger

1. **XP Beregning:**
   - **Baseline XP:** Hver kamp giver en vis mængde XP, f.eks. 100 XP for deltagelse.
   - **Bonus XP:** Sejre giver en bonus, f.eks. 50% ekstra XP. Tab kan stadig give en lille bonus XP for deltagelse.
   - **Sværhedsgrad:** Højere sværhedsgrad på AI-modstandere kan øge XP-gain med en multiplikator, f.eks. 1.5x eller 2x.

2. **Loot Beregning:**
   - **Grundlæggende Loot:** F.eks. 10 gummiænder og et random item/materiale per kamp.
   - **Bonus Loot:** Sejre mod højere sværhedsgrad giver mulighed for sjældnere loot. 
   - **Random Drops:** Chance for at få sjældne genstande eller crafting materialer, som er nødvendige for at crafte kraftfulde items.

3. **Difficulty Scaling:**
   - Som spilleren opgraderer deres helte, kan AI’ens styrke også justeres for at sikre, at udfordringen forbliver interessant. Det kan f.eks. gøres ved at introducere nye AI-typer med unikke evner eller strategier.

### Implementering i Godot

I Godot kan I oprette dette loop ved at bruge scener og scripts til at simulere MOBA-kampene og give belønninger. Nogle nøgletips:

1. **Timers:** Brug Timers til at køre 15-minutters loops for hver kamp.
2. **Scenes:** Hver kamp kan være en separat scene, der køres automatisk, mens spilleren kan interagere med UI i hovedscenen.
3. **Random Number Generators:** Brug `RandomNumberGenerator` til at skabe tilfældige elementer som loot drops eller kampresultater.
4. **Signals:** Brug signals til at kommunikere mellem kamp-scenen og hovedscenen, når en kamp er færdig, så belønninger og XP kan tildeles spilleren.

Dette system giver et godt flow mellem den automatiserede idle del og de aktive beslutninger, spilleren skal tage for at forbedre deres hold og progression.

