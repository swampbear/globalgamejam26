# Godot Multi-Developer Project Structure

```
project_root/
│
├── project.godot
├── .gitignore
├── .gitattributes
│
├── autoloads/                    # Singletons (add to Project Settings)
│   ├── game_state.gd            # Player progress, inventory, settings
│   ├── stage_manager.gd         # Handles stage loading/transitions
│   ├── audio_manager.gd         # Global audio control
│   └── events.gd                # Global signal bus
│
├── shared/                       # ⚠️ COORDINATE BEFORE EDITING
│   ├── player/
│   │   ├── player.tscn
│   │   ├── player.gd
│   │   └── player_states/
│   │
│   ├── enemies/                  # Shared enemy types
│   │   ├── base_enemy.tscn
│   │   ├── base_enemy.gd
│   │   ├── slime/
│   │   └── bat/
│   │
│   ├── interactables/            # Reusable stage elements
│   │   ├── door.tscn
│   │   ├── checkpoint.tscn
│   │   ├── collectible.tscn
│   │   └── hazard_zone.tscn
│   │
│   ├── ui/
│   │   ├── hud.tscn
│   │   ├── pause_menu.tscn
│   │   └── dialogue_box.tscn
│   │
│   └── components/               # Attachable behaviors
│       ├── health_component.gd
│       ├── hitbox.tscn
│       └── hurtbox.tscn
│
├── stages/                       # 👤 ONE DEVELOPER PER FOLDER
│   ├── base_stage/
│   │   ├── base_stage.tscn      # Template - inherit from this
│   │   └── base_stage.gd
│   │
│   ├── stage_01_forest/          # Developer A owns this
│   │   ├── forest.tscn
│   │   ├── forest.gd
│   │   ├── forest_data.tres      # Stage metadata
│   │   ├── enemies/              # Stage-specific enemies
│   │   ├── assets/               # Stage-specific art/audio
│   │   └── areas/                # Sub-sections if needed
│   │
│   ├── stage_02_cave/            # Developer B owns this
│   │   ├── cave.tscn
│   │   ├── cave.gd
│   │   ├── cave_data.tres
│   │   ├── enemies/
│   │   └── assets/
│   │
│   └── stage_03_castle/          # Developer C owns this
│       └── ...
│
├── resources/                    # Data definitions
│   ├── stage_data.gd            # Custom resource class
│   └── enemy_data.gd
│
├── assets/                       # Global/shared assets
│   ├── fonts/
│   ├── audio/
│   │   ├── music/
│   │   └── sfx/
│   ├── sprites/
│   └── shaders/
│
└── test/                         # Test scenes for debugging
    └── stage_test_harness.tscn  # Load any stage in isolation
```

## Ownership Rules

1. **Your stage folder = your territory** - Full freedom to add/edit/delete
2. **Shared folder = coordinate first** - Post in team chat before editing
3. **Autoloads = discuss changes** - These affect everyone
4. **Create, don't modify** - Need a variant? Inherit or duplicate, don't edit the original
