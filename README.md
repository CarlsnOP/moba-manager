# Moba Manager
 
### Gameplay Loop

1. **MOBA Battles (Idle Loop):**
   - **Battle Duration:** Each battle lasts 15 minutes.
   - **Automation:** Battles run automatically against AI opponents, where the player’s team (composed of the heroes they've upgraded) fights against enemy teams.
   - **Result Calculation:** At the end of each battle, a result is generated based on the combined strengths and weaknesses of the player’s team and the AI team. Include random factors like critical hits, bonuses, or unexpected events that can affect the outcome.

2. **Rewards (Loot and XP):**
   - **XP and Leveling:** XP is awarded based on the battle’s outcome, with victories granting more XP than defeats. XP is used to level up heroes, improving their stats and abilities.
   - **Loot:** Players receive loot based on the battle’s difficulty and result. Loot can include crafting materials, items, or currency (such as rubber ducks).
   - **Random Rewards:** Introduce a small chance for rare or unique rewards, which players can only obtain through certain actions or by winning consecutive battles.

3. **Progression:**
   - **Hero Upgrades:** Players use XP and loot to upgrade their heroes, either by improving their stats directly or by equipping them with better items.
   - **Crafting:** Loot can be used to craft new items or upgrade existing ones, which heroes can equip to increase their strength in future battles.
   - **Team Management:** Players can manage and customize their team, choosing which heroes to use in battles and which items to assign to them.

4. **Idle Gameplay Flow:**
   - **15-Minute Loop:** After each battle, the player receives a report on the battle’s outcome, where they can see the results, collect rewards, and prepare for the next battle.
   - **Active Decision Making:** While battles run automatically, the player must actively choose and upgrade their team and items to maximize their chances of victory.

### Reward Calculation

1. **XP Calculation:**
   - **Baseline XP:** Each battle awards a certain amount of XP, e.g., 100 XP for participation.
   - **Bonus XP:** Victories grant a bonus, e.g., 50% extra XP. Losses can still give a small participation bonus.
   - **Difficulty Scaling:** Higher difficulty AI opponents can increase XP gain with a multiplier, e.g., 1.5x or 2x.

2. **Loot Calculation:**
   - **Basic Loot:** For example, 10 rubber ducks and a random item/material per battle.
   - **Bonus Loot:** Victories against higher difficulty opponents provide a chance for rarer loot.
   - **Random Drops:** Chance to obtain rare items or crafting materials needed to craft powerful items.

3. **Difficulty Scaling:**
   - As the player upgrades their heroes, the AI’s strength can also be adjusted to ensure the challenge remains engaging. This could include introducing new AI types with unique abilities or strategies.

### Implementation in Godot

In Godot, you can implement this loop using scenes and scripts to simulate MOBA battles and distribute rewards. Some key tips:

1. **Timers:** Use Timers to run 15-minute loops for each battle.
2. **Scenes:** Each battle can be a separate scene that runs automatically, while the player interacts with the UI in the main scene.
3. **Random Number Generators:** Use `RandomNumberGenerator` to create random elements like loot drops or battle outcomes.
4. **Signals:** Use signals to communicate between the battle scene and the main scene when a battle is finished, so rewards and XP can be granted to the player.

This system provides a good flow between the automated idle component and the active decisions the player needs to make to improve their team and progress.
