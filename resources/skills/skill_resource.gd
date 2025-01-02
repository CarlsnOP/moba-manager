class_name SkillResource
extends Resource


@export_group("Settings")
@export var name: String
@export var icon: CompressedTexture2D
@export var description: String
@export var effect: String
@export var effect_growth: String
@export var cooldown: float
@export var damage: float

@export_group("Functionality")
@export var projectile: ProjectileResource
@export var ability_script: Script
