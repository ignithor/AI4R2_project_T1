function HEURISTIC(state):
    total_time ← 0

    for each crate in state.crates:
        if crate is not yet delivered:

            // Step 1: from robot to crate
            time_to_crate ← ESTIMATE_TIME_WITHOUT_CRATE(state.robot_position, crate.position)

            // Step 2: from crate to loading bay
            time_to_loading_bay ← ESTIMATE_TIME_WITH_CRATES(crate.position, state.loading_bay_position, crate.weight)

            // Step 3: loading time on belt conveyor
            loading_time ← 4

            total_time ←  time_to_crate + time_to_loading_bay + loading_time

    return total_time
    
function ESTIMATE_TIME_WITHOUT_CRATES(crate.position, state.loading_bay_position):
    distance
    time ← distance / 10
    return time


function ESTIMATE_TIME_WITH_CRATES(crate.position, state.loading_bay_position, crate.weight):
    distance
    time ← distance * crate.weight / 150
    return time


