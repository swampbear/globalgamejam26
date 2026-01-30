# Multi-Developer Godot Workflow Guide

## Quick Start for New Team Members

### 1. Clone and Setup
```bash
git clone <your-repo-url>
cd <project>
```

### 2. Open in Godot
- Open Godot 4.x
- Import the project
- Enable autoloads in Project Settings → Autoload (if not already set):
  - `res://autoloads/events.gd` → `Events`
  - `res://autoloads/game_state.gd` → `GameState`
  - `res://autoloads/stage_manager.gd` → `StageManager`

---

## Daily Workflow

### Starting Work
```bash
git checkout main
git pull origin main
git checkout -b feature/stage-02-cave-traps  # Descriptive branch name
```

### While Working
- **Stay in your stage folder** - Full creative freedom there
- **Need a shared component?** Check if it exists in `/shared` first
- **Making changes to shared?** Post in team chat first

### Before Committing
```bash
# Stage your changes
git add stages/stage_02_cave/

# Keep shared changes separate if any
git add shared/enemies/bat/  # Separate commit for shared

git commit -m "Add spike trap mechanics to cave stage"
```

### Pushing & Merging
```bash
git push origin feature/stage-02-cave-traps
# Create Pull Request on GitHub/GitLab
# Request review from at least one teammate
```

---

## Creating a New Stage (Step by Step)

### 1. Create Your Folder
```
stages/
  stage_XX_yourname/
    yourname.tscn        # Main scene
    yourname.gd          # Inherits BaseStage
    yourname_data.tres   # StageData resource
    assets/              # Stage-specific sprites, sounds
    enemies/             # Stage-specific enemy variants
```

### 2. Set Up Stage Data Resource
Create `yourname_data.tres`:
```gdscript
# In Editor: Create New Resource → StageData
stage_id = "cave_01"
display_name = "The Dark Cave"
scene_path = "res://stages/stage_02_cave/cave.tscn"
next_stage_id = "castle_01"  # or leave empty
```

### 3. Create the Scene
1. Create new scene, root node: `Node2D`
2. Attach your stage script (extends `BaseStage`)
3. Required child nodes:
   - `SpawnPoint` (Node2D) - Where player appears
4. Recommended child nodes:
   - `Checkpoints` (Node2D) - Container for checkpoint scenes
   - `Enemies` (Node2D) - Container for enemy scenes
   - `Interactables` (Node2D) - Doors, switches, pickups

### 4. Connect to Game Flow
Your stage auto-registers if you have a proper `_data.tres` file.
Test with:
```gdscript
# In any test script
StageManager.load_stage("cave_01")
```

---

## Communication Protocols

### File Ownership

| Folder | Owner | Edit Protocol |
|--------|-------|---------------|
| `stages/stage_XX_*/` | Assigned developer | Free to edit |
| `shared/player/` | Team lead / designated | Request changes |
| `shared/enemies/base_*` | Shared | Discuss first |
| `shared/enemies/<specific>/` | Creator | Ask creator |
| `autoloads/` | Team lead | RFC in chat |

### When You Need a Shared Change

1. **Post in #game-dev channel:**
   > "I need the player to have a wall-jump ability for cave stage. Anyone else need this? I can implement."

2. **If approved:** Create branch `feature/player-wall-jump`

3. **Get review** before merging to main

### Conflict Resolution

If you encounter merge conflicts in `.tscn` files:
1. **Don't panic** - Godot 4 text format is mostly mergeable
2. **For simple conflicts:** Resolve in editor
3. **For complex conflicts:** Coordinate with other developer, one person re-applies their changes

---

## Testing Your Stage

### Isolated Testing
Use the test harness scene:
```gdscript
# test/stage_test_harness.gd
func _ready():
    StageManager.load_stage("cave_01")  # Your stage ID
```

### Integration Testing
1. Pull latest `main`
2. Merge main into your branch
3. Test full game flow: previous stage → your stage → next stage

### Before Pull Request
- [ ] Stage loads without errors
- [ ] Player spawns correctly
- [ ] Checkpoints work
- [ ] Stage exit triggers properly
- [ ] No placeholder assets committed
- [ ] No debug/test code left in

---

## Branch Naming Convention

```
feature/stage-XX-description   # New stage work
feature/shared-component-name  # Shared component additions
fix/stage-XX-bug-description   # Bug fixes
refactor/system-name           # Code improvements
```

---

## Tips for Smooth Collaboration

1. **Communicate early** - Mention in chat before touching shared files
2. **Commit often** - Small commits are easier to review and revert
3. **Pull main daily** - Stay up to date to minimize conflicts
4. **Use scenes, not scripts, for variations** - Inherit scenes instead of adding if/else
5. **Document your stage** - Add comments for non-obvious mechanics

---

## Emergency: I Broke Something

### Undo last commit (not pushed):
```bash
git reset --soft HEAD~1
```

### Discard all local changes:
```bash
git checkout -- .
```

### Revert a pushed commit:
```bash
git revert <commit-hash>
git push
```

### Get help
Post in chat with the error message. We've all been there! 🙂
