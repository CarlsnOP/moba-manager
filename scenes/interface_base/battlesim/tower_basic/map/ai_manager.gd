extends Node

enum LANE_STATE { ENEMY_TOP, ENEMY_BOT, TEAM_TOP, TEAM_BOT }

@onready var ai_data = %AiData

var _lane_state: LANE_STATE

func get_nearest_point(loc: Vector2, new_state: LANE_STATE) -> Vector2:
	_lane_state = new_state
	var nearest_point = INF
	
	match _lane_state:
		LANE_STATE.ENEMY_TOP:
			
			for points in ai_data.get_enemy_top_lane_data():
				var check_distance = loc.distance_to(points)
				var nearest_distance = INF
				if check_distance < nearest_distance:
					nearest_distance = check_distance
					nearest_point = points
					
			return nearest_point
	return Vector2(0, 0)
	
	
