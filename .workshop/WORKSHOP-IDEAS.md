# Workshop Ideas - Chocolate Doom Modifications

Quick coding challenges to test Claude Code capabilities. Each can be attempted in 15-60 minutes.

---

# Easy

---

## God Mode (But Actually)

Infinite health. The classic cheat, but hardcoded. Good warmup task.

**Implementation hints:**
- Find where player takes damage
- Set health to 100 (or 999) after any damage
- Check `src/doom/p_inter.c` for damage handling

---

## Gotta Go Fast

Adjustable movement speed with hotkeys. Hold Shift to sprint at 2x, or rebind keys for speed levels.

**Implementation hints:**
- Modify `forwardmove` and `sidemove` values in `src/doom/g_game.c`
- Add key bindings for speed multiplier (e.g., 1-5 keys)
- Cap at reasonable values to prevent physics breaking

---

## Infinite Ammo

Never reload, never run dry. All weapons have unlimited ammunition.

**Implementation hints:**
- Find ammo decrement logic in weapon firing code
- Check `src/doom/p_pspr.c` for weapon state handling
- Either skip decrement or reset ammo each tick

---

## Jumpy Doom

Add a jump button. Doom didn't have jumping - now it does. Press Space to defy 1993.

**Implementation hints:**
- Add vertical momentum to player on key press
- Check `src/doom/p_user.c` for movement handling
- Need to handle "is grounded" check to prevent air jumps
- Modify `player->mo->momz` for vertical velocity

---

## Big Head Mode

Make all enemies 2x their normal size. Classic cheat code energy. Imps are now terrifying.

**Implementation hints:**
- Find where sprite scale is calculated in `src/doom/r_things.c`
- Check `R_ProjectSprite()` function around line 544
- Use `MF_COUNTKILL` flag to identify enemies (not items/decorations)
- Multiply `xscale` before storing in `vis->scale`

---

## Fear of the Dark

Low health = darker screen. The closer to death, the harder to see. Full health is full brightness.

**Implementation hints:**
- Find where colormap is set in `src/doom/p_user.c` (look for `fixedcolormap`)
- Map player health (0-100) to colormap index (higher = darker)
- Check `P_PlayerThink()` around line 364-376
- Use formula like: `colormap = (100 - player->health) / 10`

---

# Medium

---

## Run or Die

Keep moving or perish. Health drains rapidly when standing still, regenerates slowly while moving.

**Implementation hints:**
- Track player velocity in game tick
- Drain ~5-10 HP/sec when stationary
- Regenerate ~2-3 HP/sec while moving
- Check `src/doom/p_user.c` for player movement logic

---

## Monster Safari

Monsters don't attack - they flee randomly. Hunt them down. Lose health over time, gain health per kill. It's not murder, it's... population control.

**Implementation hints:**
- Modify monster AI states to remove attack states
- Add flee behavior (move away from player position)
- Implement passive health drain (~1 HP/sec)
- Award health on kills in `P_KillMobj()`

---

## Vampire Mode

No health pickups work. The only way to heal is killing enemies. Each kill restores health based on enemy type.

**Implementation hints:**
- Disable health pickup in `P_TouchSpecialThing()`
- Add health award in `P_KillMobj()` based on `mobjtype_t`
- Zombie = 5 HP, Imp = 10 HP, Demon = 20 HP, etc.

---

## Explosive Personality

Every enemy death is an explosion. Chain reactions encouraged. Chaos guaranteed.

**Implementation hints:**
- In `P_KillMobj()`, spawn a rocket explosion at death location
- Use `P_RadiusAttack()` for splash damage
- May want to reduce explosion damage to prevent instant cascade wipes
- Check `src/doom/p_mobj.c` for explosion spawning

---

# Hard

---

## SUPERHOT DOOM

Time moves only when you move. Enemies freeze, projectiles hang in the air. Bonus: add the iconic red/white aesthetic.

**Implementation hints:**
- Game logic runs in `P_Ticker()` - make it conditional on player input
- May need to decouple player input processing from world updates
- For visuals: modify palette or rendering in `src/doom/r_*.c`
- Reference: SUPERHOT's "TIME MOVES WHEN YOU MOVE" mechanic

---

## Zombie Horde Mode

10-100x more monsters, but they're slower and weaker. Survive the shambling masses.

**Implementation hints:**
- Modify monster spawn logic or duplicate spawns at map load
- Reduce monster health in `mobjinfo` table (`src/doom/info.c`)
- Slow movement by adjusting speed values
- May need to increase engine limits for thing count

---

## Roguelike Doom

Permadeath + randomized pickups. Health kits might be armor, shotgun shells might be rockets. Die once, start over from E1M1.

**Implementation hints:**
- Randomize pickup types in `P_TouchSpecialThing()`
- On player death, force restart to E1M1 instead of reload
- Could add seed display for shareable runs
- Check `src/doom/g_game.c` for level transition logic

---

## Mirror Mode

Controls are inverted. Left is right, forward is backward. Your muscle memory is now your enemy.

**Implementation hints:**
- Invert `cmd->forwardmove` and `cmd->sidemove` in `G_BuildTiccmd()`
- Optionally flip the screen horizontally in rendering
- For extra chaos: invert mouse look too
- Check `src/doom/g_game.c` for input processing

## Quick Reference

| Challenge | Difficulty | Key Files |
|-----------|------------|-----------|
| God Mode | Easy | `p_inter.c` |
| Gotta Go Fast | Easy | `g_game.c` |
| Infinite Ammo | Easy | `p_pspr.c` |
| Jumpy Doom | Easy | `p_user.c` |
| Big Head Mode | Easy | `r_things.c` |
| Fear of the Dark | Easy | `p_user.c` |
| Run or Die | Medium | `p_user.c`, `p_tick.c` |
| Monster Safari | Medium | `p_enemy.c`, `p_inter.c` |
| Vampire Mode | Medium | `p_inter.c`, `p_mobj.c` |
| Explosive Personality | Medium | `p_mobj.c` |
| SUPERHOT DOOM | Hard | `p_tick.c`, `g_game.c`, `r_*.c` |
| Zombie Horde Mode | Hard | `p_mobj.c`, `info.c` |
| Roguelike Doom | Hard | `p_inter.c`, `g_game.c` |
| Mirror Mode | Hard | `g_game.c`, `r_*.c` |

---

*Workshop exercises for testing AI coding assistants with a real C codebase.*
